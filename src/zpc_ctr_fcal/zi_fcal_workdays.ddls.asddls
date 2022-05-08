@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface view: Factory cal. - workdays'
define root view entity ZI_FCAL_WORKDAYS
  as select from ztfcal_w
  composition [0..*] of ZI_FCAL_HOLIDAYS as Holidays
{
  key calendar              as Calendar,
  key cal_key               as CalKey,
      work_monday           as WorkMonday,
      work_tuesday          as WorkTuesday,
      work_wednesday        as WorkWednesday,
      work_thursday         as WorkThursday,
      work_friday           as WorkFriday,
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

      Holidays
}
