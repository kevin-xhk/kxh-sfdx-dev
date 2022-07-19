/**
 * Created by kxhakaj on 7/5/2022.
 */

public with sharing class MergingDuplicates {

    // so1 has priority over second
//    public String mergeDuplicates(SObject so1, SObject so2){
//        // make sure 2 sobjs are of the same type
//        if( so1.getSObjectType() != so2.getSObjectType()){
//            return 'error';
//        }
//
//        Map<String, Object> so1Fields = so1.getPopulatedFieldsAsMap();
//
//        SObject cloneObj1 = so1.clone(true, true, true, true);
//        Map<String, Object> cloneObj1Fields = cloneObj1.getPopulatedFieldsAsMap();
//
//        Map<String, Object> so2Fields = so2.getPopulatedFieldsAsMap();
//
//
//        SObject mergedObject = new SObject();
//
////        SObject mergedRecord = (SObject)JSON.deserialize('{}', classType);
////        List<Object> output = new List<Object>
//
//        // for each field in so2, check if DNE in so1
//        // if so, give it to so1
//        // if so1Field == so2Field, don't do anything
//        for( String fieldKey : so2Fields.keySet()){
//            if ( !cloneObj1Fields.containsKey(fieldKey) ){
////                cloneObj1. = so2Fields.get(fieldKey);
//
////                cloneObj1Fields.put(fieldKey, so2Fields.get(fieldKey));
//            }
//        }
//
//        System.debug(so1Fields);
//
//        return 'success';
//    }

    /**
     * @param so1 source SObject, edited by reference
     * @param so2 duplicate SObject
     */
    public static void mergeDuplicates2(SObject so1, SObject so2) {

        // make sure two SObject's are of same type
        if ( so1.getSObjectType() != so2.getSObjectType() ) {
            System.debug('mergeDuplicates2(): parameters are not of same type');
            return;
        }

        // declarations here
        Map<String, Object> so1Fields = so1.getPopulatedFieldsAsMap();
        Map<String, Object> so2Fields = so2.getPopulatedFieldsAsMap();

        // loop through so2 fields, add ones not present in so1
        for ( String fieldKey : so2Fields.keySet() ) {
            if ( !so1Fields.containsKey(fieldKey) ) {
                so1.put(fieldKey, so2Fields.get(fieldKey));
            }
        }
    }

}