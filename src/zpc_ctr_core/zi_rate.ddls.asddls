@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface view: Project rate'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_RATE
  as select from ztrate as Rate
  association to parent ZI_PROJECT as Project
    on $projection.ProjectId = Project.ProjectID
{
  key project_id            as ProjectId,
  key to_date               as ToDate,
      from_date             as FromDate,
      hourly_rate           as HourlyRate,
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
      Project
}
