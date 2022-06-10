param location string = resourceGroup().location
param env string
param appServicePlanName string

resource appServicePlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name:appServicePlanName
  location:location
  tags:{
    environment:env
  }
  sku:{
    name:'S1'
    tier:'Standard'
    size:'S1'
    family:'S'
    capacity:1
  }
  kind:'app'
}

output appPlanId string = appServicePlan.id
output appPlanName string = appServicePlan.name
