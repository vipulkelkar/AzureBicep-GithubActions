targetScope = 'resourceGroup'
param storageAccountName string
param environment string

param location string = resourceGroup().location

resource apiApp_StorageAcc 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageAccountName
  location: location
  tags:{
    environment:environment
  }
  kind: 'StorageV2'
  sku:{
    name:'Standard_LRS'
  }
}
