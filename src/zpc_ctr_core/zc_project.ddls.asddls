@EndUserText.label: 'Consumption View: Project'
@AccessControl.authorizationCheck: #CHECK

@UI: {
  headerInfo: {
    typeName: 'Project',
    typeNamePlural: 'Projects'
  }
}
define root view entity ZC_PROJECT
  as projection on ZI_PROJECT
{
      @UI.facet: [
        {
          id: 'Project',
          purpose: #STANDARD,
          type: #FIELDGROUP_REFERENCE,
          label: 'Project',
          position: 10,
          targetQualifier: 'ProjectData'
        },
        {
          id: 'AdminData',
          purpose: #STANDARD,
          type: #FIELDGROUP_REFERENCE,
          label: 'Administrative info',
          position: 20,
          targetQualifier: 'AdminInfoData'
        },
        {
          id: 'Rate',
          purpose: #STANDARD,
          type: #LINEITEM_REFERENCE,
          label: 'Rate',
          position: 30,
          targetElement: 'Rate'
        }
      ]

      @UI: {
        lineItem: [{ position: 10, importance: #HIGH }],
        identification: [{ position: 10, label: 'ID' }]
      }
      @Search.defaultSearchElement: true
  key ProjectID,
  
      @UI: {
        lineItem: [{ hidden: true }],
        fieldGroup: [{ qualifier: 'ProjectData',  position: 10 }]
      }
      Type,

      @UI: {
        lineItem: [{ position: 20, importance: #MEDIUM }],
        fieldGroup: [{ qualifier: 'ProjectData',  position: 20 }]
      }
      Description,

      @UI: {
        lineItem: [{ position: 30, importance: #LOW }],
        fieldGroup: [{ qualifier: 'ProjectData',  position: 30 }]
      }
      FromDate,

      @UI: {
        lineItem: [{ position: 40, importance: #LOW }],
        identification: [{ position: 50, label: 'Valid to' }],
        fieldGroup: [{ qualifier: 'ProjectData',  position: 40 }]
      }
      ToDate,
      
      @UI: {
        lineItem: [{ hidden: true }],
        identification: [{ position: 60, label: 'Calendar country' }],
        fieldGroup: [{ qualifier: 'ProjectData',  position: 50 }]
      }
      Calendar,

      @UI: {
        lineItem: [{ hidden: true }],
        fieldGroup: [{ qualifier: 'AdminInfoData',  position: 10 }]
      }
      CreatedBy,

      @UI: {
        lineItem: [{ hidden: true }],
        identification: [{ position: 70, label: 'Created at' }],
        fieldGroup: [{ qualifier: 'AdminInfoData',  position: 20 }]
      }
      CreatedAt,

      @UI: {
        lineItem: [{ hidden: true }],
        identification: [{ position: 80, label: 'Changed by' }],
        fieldGroup: [{ qualifier: 'AdminInfoData',  position: 30 }]
      }
      LastChangedBy,

      @UI: {
        lineItem: [{ hidden: true }],
        identification: [{ position: 90, label: 'Changed at' }],
        fieldGroup: [{ qualifier: 'AdminInfoData',  position: 40 }]
      }
      LastChangedAt,

      @UI.dataFieldDefault: [{hidden: true}]
      @UI.identification: [{ hidden: true }]
      LocalLastChangedAt,

      /* Associations */
      Rate: redirected to composition child ZC_RATE
}
