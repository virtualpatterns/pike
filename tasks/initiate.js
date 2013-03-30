// Local
configuration = { '_id':'pike',
                  'members':[ { '_id':0, 'host':'localhost:27017' },
                              { '_id':1, 'host':'localhost:27018' },
                              { '_id':2, 'host':'localhost:27019', 'arbiterOnly':true } ] }

// Development
configuration = { '_id':'pike',
                  'members':[ { '_id':0, 'host':'SCALENE.local:27017' },
                              { '_id':1, 'host':'OBTUSE.local:27017' },
                              { '_id':2, 'host':'ISOSCELES.local:27017', 'arbiterOnly':true } ] }
