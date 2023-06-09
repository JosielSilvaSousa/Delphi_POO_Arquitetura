{***************************************************************************}
{                                                                           }
{           Spring Framework for Delphi                                     }
{                                                                           }
{           Copyright (c) 2009-2018 Spring4D Team                           }
{                                                                           }
{           http://www.spring4d.org                                         }
{                                                                           }
{***************************************************************************}
{                                                                           }
{  Licensed under the Apache License, Version 2.0 (the "License");          }
{  you may not use this file except in compliance with the License.         }
{  You may obtain a copy of the License at                                  }
{                                                                           }
{      http://www.apache.org/licenses/LICENSE-2.0                           }
{                                                                           }
{  Unless required by applicable law or agreed to in writing, software      }
{  distributed under the License is distributed on an "AS IS" BASIS,        }
{  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{  See the License for the specific language governing permissions and      }
{  limitations under the License.                                           }
{                                                                           }
{***************************************************************************}



unit Spring.Container.CreationContext;

interface

uses
  Rtti,
  SysUtils,
  Spring,
  Spring.Collections,
  Spring.Container.Core;

type
  TCreationContext = class(TInterfacedObject, ICreationContext)
  private
    fResolutionStack: IStack<TComponentModel>;
    fModel: TComponentModel;
    fArguments: IList<TValue>;
    fPerResolveInstances: IDictionary<TComponentModel, TValue>;
    fNamedArguments: IList<TNamedValue>;
    fTypedArguments: IList<TTypedValue>;
    fLock: IReadWriteSync;
  public
    constructor Create(const model: TComponentModel;
      const arguments: array of TValue);
{$IFNDEF AUTOREFCOUNT}
    destructor Destroy; override;
{$ENDIF}

    function CanResolve(const context: ICreationContext;
      const dependency: TDependencyModel; const argument: TValue): Boolean;
    function Resolve(const context: ICreationContext;
      const dependency: TDependencyModel; const argument: TValue): TValue;

    function EnterResolution(const model: TComponentModel;
      out instance: TValue): Boolean;
    procedure LeaveResolution(const model: TComponentModel);

    function AddArgument(const argument: TValue): Integer;
    procedure RemoveTypedArgument(index: Integer);
    procedure AddPerResolve(const model: TComponentModel; const instance: TValue);
    function TryHandle(const injection: IInjection;
      out handled: IInjection): Boolean;
  end;

implementation

uses
  TypInfo,
  Spring.Container.Common,
  Spring.Container.Injection,
  Spring.Container.ResourceStrings,
  Spring.Reflection;

{$IFNDEF AUTOREFCOUNT}
type
  TInterfacedObjectAccess = class(TInterfacedObject);
{$ENDIF}

{$REGION 'TCreationContext'}

constructor TCreationContext.Create(const model: TComponentModel;
  const arguments: array of TValue);
var
  i: Integer;
begin
  inherited Create;
  fLock := TMREWSync.Create;
  fResolutionStack := TCollections.CreateStack<TComponentModel>;
  fModel := model;
  fArguments := TCollections.CreateList<TValue>;
  fNamedArguments := TCollections.CreateList<TNamedValue>;
  fTypedArguments := TCollections.CreateList<TTypedValue>;
  for i := Low(arguments) to High(arguments) do
    AddArgument(arguments[i]);
  fPerResolveInstances := TCollections.CreateDictionary<TComponentModel, TValue>;
end;

{$IFNDEF AUTOREFCOUNT}
destructor TCreationContext.Destroy;
var
  instance: TValue;
  interfacedObject: TInterfacedObject;
begin
  for instance in fPerResolveInstances.Values do
    if instance.TryAsType<TInterfacedObject>(interfacedObject) and Assigned(interfacedObject) then
      AtomicDecrement(TInterfacedObjectAccess(interfacedObject).fRefCount);
  inherited Destroy;
end;
{$ENDIF}

function TCreationContext.AddArgument(const argument: TValue): Integer;
begin
  fLock.BeginWrite;
  try
    if argument.IsType<TTypedValue> then
      Result := fTypedArguments.Add(argument)
    else if argument.IsType<TNamedValue> then
      Result := fNamedArguments.Add(argument)
    else
      Result := fArguments.Add(argument);
  finally
    fLock.EndWrite
  end;
end;

procedure TCreationContext.AddPerResolve(const model: TComponentModel;
  const instance: TValue);
{$IFNDEF AUTOREFCOUNT}
var
  interfacedObject: TInterfacedObject;
{$ENDIF}
begin
  fLock.BeginWrite;
  try
    fPerResolveInstances.Add(model, instance);
{$IFNDEF AUTOREFCOUNT}
    if instance.TryAsType<TInterfacedObject>(interfacedObject) and Assigned(interfacedObject) then
      AtomicIncrement(TInterfacedObjectAccess(interfacedObject).fRefCount);
{$ENDIF}
  finally
    fLock.EndWrite;
  end;
end;

function TCreationContext.CanResolve(const context: ICreationContext;
  const dependency: TDependencyModel; const argument: TValue): Boolean;
var
  i: Integer;
begin
  fLock.BeginRead;
  try
    for i := fTypedArguments.Count - 1 downto 0 do // check most recently added first
      if fTypedArguments[i].TypeInfo = dependency.TypeInfo then
        Exit(True);
    Result := False;
  finally
    fLock.EndRead;
  end;
end;

function TCreationContext.TryHandle(const injection: IInjection;
  out handled: IInjection): Boolean;
var
  arguments: TArray<TValue>;
  i: Integer;
  parameters: TArray<TRttiParameter>;
  value: TNamedValue;
begin
  fLock.BeginRead;
  try
    arguments := Copy(injection.Arguments);
    if not fModel.ConstructorInjections.Contains(injection) then
    begin
      handled := injection;
      Exit(True);
    end;

    parameters := injection.Target.AsMethod.GetParameters;
    // RTTI cannot handle open array parameters
    for i := Low(parameters) to High(parameters) do
      if pfArray in parameters[i].Flags then
        Exit(False);
    if Length(parameters) = fArguments.Count then
    begin
      // arguments for ctor are provided and count is correct
      for i := Low(parameters) to High(parameters) do // check all parameters
        if fArguments[i].IsType(parameters[i].ParamType.Handle) then
          arguments[i] := fArguments[i]
        else
          Exit(False); // argument and parameter types did not match
    end
    else if fArguments.Any then
      Exit(False);
    for value in fNamedArguments do // check all named arguments
    begin
      Result := False;
      for i := Low(parameters) to High(parameters) do
      begin // look for parameter that matches the name and type
        if SameText(parameters[i].Name, value.Name)
          and value.Value.IsType(parameters[i].ParamType.Handle) then
        begin
          arguments[i] := value.Value;
          Result := True;
          Break;
        end;
      end;
      if not Result then // named argument was not found
        Exit;
    end;
  finally
    fLock.EndRead;
  end;

  Result := True; // all parameters are handled - create new injection
  handled := TConstructorInjection.Create;
  handled.Initialize(injection.Target);
  handled.InitializeArguments(arguments);
  for i := 0 to injection.DependencyCount - 1 do
    handled.Dependencies[i] := injection.Dependencies[i];
end;

function TCreationContext.EnterResolution(const model: TComponentModel;
  out instance: TValue): Boolean;
begin
  Result := False;
  fLock.BeginWrite;
  try
    if not Assigned(fModel) then // set the model if we don't know it yet
      fModel := model;
    if fPerResolveInstances.TryGetValue(model, instance) then
      Exit;
    if fResolutionStack.Contains(model) then
      if model.LifetimeType in [TLifetimeType.Singleton,
        TLifetimeType.PerResolve, TLifetimeType.SingletonPerThread] then
        Exit
      else
        raise ECircularDependencyException.CreateResFmt(
          @SCircularDependencyDetected, [model.ComponentTypeName]);
    fResolutionStack.Push(model);
    Result := True;
  finally
    if not Result then
      fLock.EndWrite;
  end;
end;

procedure TCreationContext.LeaveResolution(const model: TComponentModel);
begin
  try
    if fResolutionStack.Pop <> model then
    raise EResolveException.CreateRes(@SResolutionStackUnbalanced);
  finally
    fLock.EndWrite;
  end;
end;

procedure TCreationContext.RemoveTypedArgument(index: Integer);
begin
  fLock.BeginWrite;
  try
    fTypedArguments.Delete(index);
  finally
    fLock.EndWrite;
  end;
end;

function TCreationContext.Resolve(const context: ICreationContext;
  const dependency: TDependencyModel; const argument: TValue): TValue;
var
  i: Integer;
begin
  fLock.BeginRead;
  try
    for i := fTypedArguments.Count - 1 downto 0 do
      if fTypedArguments[i].TypeInfo = dependency.TypeInfo then
        Exit(fTypedArguments[i].Value);
  finally
    fLock.EndRead;
  end;
  raise EResolveException.CreateResFmt(@SCannotResolveType, [dependency.Name]);
end;

{$ENDREGION}


end.
