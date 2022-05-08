@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface view: Project'
define root view entity ZI_PROJECT
  as select from ztproject as Project
  composition [0..*] of ZI_RATE as Rate
{
  key project_id            as ProjectID,
      @Consumption.valueHelpDefinition: [{entity: { name: 'ZI_PROJ_TYPE', 
                                                    element: 'Type'  }}]
      type                  as Type,
      description           as Description,
      from_date             as FromDate,
      to_date               as ToDate,
      @Consumption.valueHelpDefinition: [{entity: { name: 'I_Country', 
                                                    element: 'Country'  }}]
      calendar              as Calendar,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      /* Associations */
      Rate
}
