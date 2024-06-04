param functionAppName string
param functionAppNameStaging string
param apiClientId string
param audienceId string
param tenantId string

resource functionApp 'Microsoft.Web/sites@2022-03-01' existing = {
  name: functionAppName
}

resource functionAppStaging 'Microsoft.Web/sites/slots@2022-03-01' existing = {
  name: functionAppNameStaging
}

resource functionAppAuthSettings 'Microsoft.Web/sites/config@2022-03-01' = {
  name: 'authsettingsV2'
  parent: functionApp
  properties: {
    globalValidation: {
      requireAuthentication: true
      unauthenticatedClientAction: 'Return401'
    }  
    identityProviders: {
      azureActiveDirectory: {
        enabled: true  
        login: {
          disableWWWAuthenticate: false
        }
        registration: {
          clientId: apiClientId
          openIdIssuer: 'https://sts.windows.net/${tenantId}/'
        }
        validation: {
          allowedAudiences: [
            audienceId
          ]
        }
      }
    }
    platform: {
      enabled: true
      runtimeVersion: '1.0.0'
    }
  }
}

resource functionAppStagingAuthSettings 'Microsoft.Web/sites/slots/config@2022-03-01' = {
  name: 'authsettingsV2'
  parent: functionAppStaging
  properties: {
    globalValidation: {
      requireAuthentication: true
      unauthenticatedClientAction: 'Return401'
    }  
    identityProviders: {
      azureActiveDirectory: {
        enabled: true  
        login: {
          disableWWWAuthenticate: false
        }
        registration: {
          clientId: apiClientId
          openIdIssuer: 'https://sts.windows.net/${tenantId}/'
        }
        validation: {
          allowedAudiences: [
            audienceId
          ]
        }
      }
    }
    platform: {
      enabled: true
      runtimeVersion: '1.0.0'
    }
  }
}
