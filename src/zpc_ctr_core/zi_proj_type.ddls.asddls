@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface view: Project type'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
@ObjectModel : { resultSet.sizeCategory: #XS }
define view entity ZI_PROJ_TYPE
  as select from ztproj_type
{
  key type  as Type,
      descr as Descr
}
