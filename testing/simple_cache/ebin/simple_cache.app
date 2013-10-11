{application,simple_cache,
             [{description,"A simple caching system"},
              {vsn,"0.1.0"},
              {modules,[sc_app,sc_element,sc_element_sup,sc_event,
                        sc_event_logger,sc_store,sc_sup,simple_cache]},
              {registered,[sc_sup]},
              {applications,[kernel,sasl,stdlib]},
              {mod,{sc_app,[]}}]}.
