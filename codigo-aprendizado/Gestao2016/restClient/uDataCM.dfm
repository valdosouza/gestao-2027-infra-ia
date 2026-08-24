object DataCM: TDataCM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 271
  Width = 415
  object DSRC: TDSRestConnection
    Host = '192.168.100.24'
    Port = 221
    Context = 'api/'
    RESTContext = 'gestao/'
    LoginPrompt = False
    Left = 48
    Top = 40
    UniqueId = '{6224B6BF-AB0B-4870-9310-C299A1656D51}'
  end
end
