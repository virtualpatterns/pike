set :default_environment, default_environment.merge('RUBY_HEAP_MIN_SLOTS'           => 100000,
                                                    'RUBY_HEAP_SLOTS_INCREMENT'     => 50000,
                                                    'RUBY_HEAP_SLOTS_GROWTH_FACTOR' => 1,
                                                    'RUBY_GC_MALLOC_LIMIT'          => 10000000,
                                                    'RUBY_APP_CONFIGURATION'        => 'default',
                                                    'PATH'                          => '$PATH:/opt/ruby/bin')
set :branch,              'development'
set :user,                'fficnar'

role :data,         'rhombus.zapto.org:3022'
role :application,  'rhombus.zapto.org:3022'
