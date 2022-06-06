param appInsightName string
param location string = resourceGroup().location
param env string

resource appInsight 'Microsoft.Insights/components@2020-02-02' = {
  name:appInsightName
  location:location
  kind:'web'
  tags:{
    environment:env
  }
  properties:{
    Application_Type:'web'
    publicNetworkAccessForIngestion:'Enabled'
    publicNetworkAccessForQuery:'Enabled'
  }
}

output appInsightConnectionString string = appInsight.properties.ConnectionString
output appInsightInstrumentationKey string = appInsight.properties.InstrumentationKey
