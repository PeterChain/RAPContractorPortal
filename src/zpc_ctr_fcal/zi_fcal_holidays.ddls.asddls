@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface view: Factory cal. - holidays'
define view entity ZI_FCAL_HOLIDAYS
  as select from ztfcal_h
  association to parent ZI_FCAL_WORKDAYS as Workdays on  $projection.Calendar = Workdays.Calendar
                                                     and $projection.CalKey   = Workdays.CalKey
{
  key calendar              as Calendar,
  key cal_key               as CalKey,
  key cal_hkey              as CalHkey,
      cal_year              as CalYear,
      cal_month             as CalMonth,
      cal_day               as CalDay,
      name                  as Name,
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

      Workdays
}
