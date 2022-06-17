param location string = resourceGroup().location
param keyVaultName string
param env string
param tenantId string
param secretName string
//param subnetId string

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
    accessPolicies:[
      {
        objectId:'b59ef84c-991d-4f7f-a8b6-3c5347bf8e98'
        tenantId:tenantId
        permissions:{
          secrets:[
            'get'
            'list'
            'set'
          ]
        }
      }
    ]
    // networkAcls:{
    //   defaultAction:'Deny'
    //   virtualNetworkRules:[
    //     {
    //       id:subnetId
    //     }
    //   ]
    // }
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
