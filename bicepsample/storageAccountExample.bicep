targetScope = 'resourceGroup'

param location string = resourceGroup().location

resource apiApp_StorageAcc 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: 'githubactionsteststg'
  location: location
  tags:{
    environment:'dev'
  }
  kind: 'StorageV2'
  sku:{
    name:'Standard_LRS'
  }
}