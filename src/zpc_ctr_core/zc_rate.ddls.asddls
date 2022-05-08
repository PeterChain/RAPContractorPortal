@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true

@UI: {
  headerInfo: {
    typeName: 'Rate',
    typeNamePlural: 'Rates'
  }
}
define view entity ZC_RATE
  as projection on ZI_RATE as Rate
{
      @UI: {
            lineItem: [{ hidden: true }],
            identification: [{ hidden: true }]
          }
      @Search.defaultSearchElement: true
  key ProjectId,

      @UI: {
        lineItem: [{ position: 10 }],
        identification: [{ position: 20 }]
      }
      @Semantics.businessDate.to: true
  key ToDate,

      @UI: {
        lineItem: [{ position: 20 }],
        identification: [{ position: 30 }]
      }
      @Semantics.businessDate.from: true
      FromDate,
      
      @UI: {
        lineItem: [{ position: 30 }],
        identification: [{ position: 40 }]
      }
      HourlyRate,
      
      @UI: {
        lineItem: [{ hidden: true }],
        identification: [{ position: 50 }]
      }
      CreatedBy,
      
      @UI: {
        lineItem: [{ hidden: true }],
        identification: [{ position: 60 }]
      }
      @Semantics.systemDateTime.createdAt: true
      CreatedAt,
      
      @UI: {
        lineItem: [{ hidden: true }],
        identification: [{ position: 60 }]
      }
      LastChangedBy,
      
      @UI: {
        lineItem: [{ hidden: true }],
        identification: [{ position: 70 }]
      }
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,
      
      @UI: {
        lineItem: [{ hidden: true }],
        identification: [{ position: 80 }]
      }
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,

      /* Association */
      Project : redirected to parent ZC_PROJECT
}
