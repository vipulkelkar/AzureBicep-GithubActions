param location string = resourceGroup().location
param env string
param functionAppName string
param appPlanId string
param storageAccountName string
param subnetId string

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
          'name':'APPINSIGHTS_INSTRUMENTATIONKEY'
          'value':appInsightInstrumentationKey
        }
        {
          'name':'AzureWebJobsStorage'
          'value':'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};AccountKey=${storageAccountKey};EndpointSuffix=core.windows.net'
        }
      ]
    }
    serverFarmId:appPlanId
  }
}

resource vnetIntegration 'Microsoft.Web/sites/networkConfig@2021-03-01' = {
  name:'virtualNetwork'
  parent:functionApp
  properties:{
    subnetResourceId:subnetId
    swiftSupported:true
  }
}

