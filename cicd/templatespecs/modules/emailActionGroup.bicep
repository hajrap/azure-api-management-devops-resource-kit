param emailActionGroup_name string
param emailActionGroup_displayName string
param emailActionGroup_enabled bool
param emalActionGroup_emails array


resource emailActionGroupResource 'microsoft.insights/actionGroups@2019-06-01' = {
  name: emailActionGroup_name
  location: 'global'
  tags: {}
  properties: {
    groupShortName: emailActionGroup_displayName
    enabled: emailActionGroup_enabled
    emailReceivers: emalActionGroup_emails
  }
}

output emailActionGroupResourceId string = emailActionGroupResource.id
