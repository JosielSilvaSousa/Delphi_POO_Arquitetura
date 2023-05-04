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

unit Spring.Tests.DesignPatterns;



interface

uses
  TestFramework,
  Spring.TestUtils,
  Spring.DesignPatterns;

type
  TTestSingleton = class(TTestcase)
  published
    procedure TestGetInstance;
  end;

implementation

{$REGION 'TTestSingleton'}

type
  TSingletonObject = class
  end;

procedure TTestSingleton.TestGetInstance;
var
  obj1, obj2: TSingletonObject;
begin
  obj1 := TSingleton.GetInstance<TSingletonObject>;
  RegisterExpectedMemoryLeak(obj1);
  obj2 := TSingleton.GetInstance<TSingletonObject>;
  CheckNotNull(obj1, 'obj1');
  CheckNotNull(obj2, 'obj2');
  CheckSame(obj1, obj2);
end;

{$ENDREGION}

end.

