# -*- coding: utf-8 -*-
FakeWeb.register_uri(:get, %r|http://maps\.googleapis\.com/|, :body => '{
                       "results" : [
                         {
                           "address_components" : [
                             {
                               "long_name" : "19",
                               "short_name" : "19",
                               "types" : [ "street_number" ]
                             },
                             {
                               "long_name" : "Rue de Chartres",
                               "short_name" : "Rue de Chartres",
                               "types" : [ "route" ]
                             },
                             {
                               "long_name" : "18th arrondissement of Paris",
                               "short_name" : "18th arrondissement of Paris",
                               "types" : [ "sublocality", "political" ]
                             },
                             {
                               "long_name" : "Paris",
                               "short_name" : "Paris",
                               "types" : [ "locality", "political" ]
                             },
                             {
                               "long_name" : "Paris",
                               "short_name" : "75",
                               "types" : [ "administrative_area_level_2", "political" ]
                             },
                             {
                               "long_name" : "Île-de-France",
                               "short_name" : "IdF",
                               "types" : [ "administrative_area_level_1", "political" ]
                             },
                             {
                               "long_name" : "France",
                               "short_name" : "FR",
                               "types" : [ "country", "political" ]
                             },
                             {
                               "long_name" : "75018",
                               "short_name" : "75018",
                               "types" : [ "postal_code" ]
                             }
                           ],
                           "formatted_address" : "19 Rue de Chartres, 75018 Paris, France",
                           "geometry" : {
                             "location" : {
                               "lat" : 48.88476240,
                               "lng" : 2.35295720
                             },
                             "location_type" : "ROOFTOP",
                             "viewport" : {
                               "northeast" : {
                                 "lat" : 48.88611138029150,
                                 "lng" : 2.354306180291502
                               },
                               "southwest" : {
                                 "lat" : 48.88341341970850,
                                 "lng" : 2.351608219708498
                               }
                             }
                           },
                           "types" : [ "street_address" ]
                         }
                       ],
                       "status" : "OK"
                     }'
                 )
