param location string = resourceGroup().location
param keyVaultName string
param env string
param tenantId string
param secretName string

@secure()
param topSecretValue string


resource myVault 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name:keyVaultName
  location:location
  tags:{
    environment:env
  }
  properties:{
    sku:{
      family:'A'
      name:'standard'
    }
    tenantId:tenantId
  }
}


resource myTopSecret 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  name:secretName
  parent:myVault
  properties:{
    attributes:{
      enabled:true
    }
    contentType:'string'
    value:topSecretValue
  }
}

output vaultName string = myVault.name
output secretName string = myTopSecret.name
