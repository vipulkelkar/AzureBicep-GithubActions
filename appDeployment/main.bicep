param location string = resourceGroup().location
param storageAccountName string
param env string

resource stgAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name:'myteststgacc'
  location:location
  tags:{
    environment:env
  }
  kind:'StorageV2'
  sku:{
    name:'Standard_LRS'
  }
}

output stgAccountID string = stgAccount.id
output stgAccountName string = stgAccount.name
var accountKey = listkeys(stgAccount.id,stgAccount.apiVersion).keys[0].value
output stgAccountKey string = accountKey
