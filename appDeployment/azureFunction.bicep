param location string = resourceGroup().location
param env string
param functionAppName string
param appPlanId string

@secure()
param appInsightInstrumentationKey string
@secure()
param storageAccountKey string

resource functionApp 'Microsoft.Web/sites@2021-03-01' = {
  name:functionAppName
  location:location
  kind:'functionApp'
  tags:{
    environment:env
  }
  properties:{
    siteConfig:{
      appSettings:[
        {
          'name':''
          'value':''
        }
        {
          'name':''
          'value':''
        }
      ]
    }
    serverFarmId:appPlanId
  }
}

