package AUApp::Model::DB;
use Moo;
extends 'Catalyst::Model::DBIC::Schema';
with 'RapidApp::Util::Role::ModelDBIC';

use strict;
use warnings;

__PACKAGE__->config(
  schema_class => 'AUApp::DB',

  connect_info => {
    dsn         => 'dbi:Pg:dbname=au;host=localhost;port=5432',
    user        => 'au',
    password    => 'Vienna',
    quote_names => q{1},
  },

  # Configs for the RapidApp::RapidDbic Catalyst Plugin:
  RapidDbic => {

    # use only the relationship column of a foreign-key and hide the
    # redundant literal column when the names are different:
    hide_fk_columns => 1,

    # The grid_class is used to automatically setup a module for each source in the
    # navtree with the grid_params for each source supplied as its options.
    grid_class  => 'AUApp::Module::GridBase',
    grid_params => {
      # The special '*defaults' key applies to all sources at once
      '*defaults' => {
        include_colspec => ['*'],    #<-- default already ['*']
        ## uncomment these lines to turn on editing in all grids
        #updatable_colspec   => ['*'],
        #creatable_colspec   => ['*'],
        #destroyable_relspec => ['*'],
        extra_extconfig => {
          store_button_cnf => {
            save => { showtext => 1 },
            undo => { showtext => 1 }
          }
        }
      },
      'ProgramOutput' => {
      	include_colspec => ['*', 'program.program_flows', 'program.program_inputs']
      }
    },

    # TableSpecs define extra RapidApp-specific metadata for each source
    # and is used/available to all modules which interact with them
    TableSpecs => {
      'Abstractlibrary' => {
        display_column => 'name',
        title          => 'Library',
        title_multi    => 'Librarys',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          name => {
            header => 'name',
            width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          uri => {
            header => 'uri',
            width => 400,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          library_type => {
            header => 'type',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          version => {
            header => 'version',
            no_column => 1,
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          sublibrary_type => {
            header => 'subtype',
            no_column => 1,
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          database_id => {
            header => 'database id',
            no_column => 1,
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          prime_library => {
            header => 'prime lib',
            width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          abstractlibraries => {
            header => 'libraries',
            width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          input_outputs => {
            header => 'input_outputs',
            width => 120,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          programs => {
            header => 'programs',
            width => 120,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          id => {
            header => 'id',
            width => 30,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'AllCall' => {
        #display_column => '',
        title        => 'All Call',
        title_multi  => 'All Calls',
        iconCls      => 'ra-icon-pg',
        multiIconCls => 'ra-icon-pg-multi',
        columns      => {
          program => {
            header => 'program',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          called => {
            header => 'called',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'BusinessRule' => {
        display_column => 'name',
        title          => 'Business Rule',
        title_multi    => 'Business Rules',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          flow => {
            header => 'flow',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          name => {
            header => 'name',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          domain => {
            header => 'domain',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          complexity => {
            header => 'complexity',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          priority => {
            header => 'priority',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          relevant => {
            header => 'relevant',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          required => {
            header => 'required',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          comment => {
            header => 'comment',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'CommentIo' => {
        display_column => 'comment',
        title          => 'Comment InputOutput',
        title_multi    => 'Comments InputOutput',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          id => {
            header => 'id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          input_output => {
            header => 'input_output',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          line_nr_from => {
            header => 'line_nr_from',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          line_nr_to => {
            header => 'line_nr_to',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          is_io_description => {
            header => 'is_io_description',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          comment => {
            header => 'comment',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'CommentPrg' => {
        display_column => 'comment',
        title          => 'Comment Program',
        title_multi    => 'Comments Program',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          id => {
            header => 'id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program => {
            header => 'program',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          line_nr_from => {
            header => 'line_nr_from',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          line_nr_to => {
            header => 'line_nr_to',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          is_io_description => {
            header => 'is_io_description',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          comment => {
            header => 'comment',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'Dynamiccall' => {
        display_column => 'program',
        title          => 'Dynamiccall',
        title_multi    => 'Dynamiccalls',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          id => {
            header => 'id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          version => {
            header => 'version',
            no_column => 1,
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program => {
            header => 'program',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          statement_id => {
            header => 'statement_id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            profiles => [ 'hidden' ],
          },
          statement => {
            header => 'statement',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'Fieldtofield' => {
        display_column => 'id',
        title          => 'Field to field',
        title_multi    => 'Field to fields',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          id => {
            header => 'id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          source_id => {
            header => 'source',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          target_id => {
            header => 'target',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          flow_id => {
            header => 'flow_id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            profiles => [ 'hidden' ],
          },
          input_id => {
            header => 'input_id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            profiles => [ 'hidden' ],
          },
        },
      },
      'Flow' => {
        display_column => 'output',
        title          => 'Flow to',
        title_multi    => 'Flows to',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          id => {
            header => 'id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          version => {
            header => 'version',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          output => {
            header => 'output',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          fieldtofields => {
            header => 'fieldtofields',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          flow_inputs => {
            header => 'flow_inputs',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program_flows => {
            header => 'program_flows',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          steps => {
            header => 'steps',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'FlowInput' => {

        display_column => 'input',
        title        => 'Flow Input',
        title_multi  => 'Flow Inputs',
        iconCls      => 'ra-icon-pg',
        multiIconCls => 'ra-icon-pg-multi',
        columns      => {
          flow => {
            header => 'flow',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          input => {
            header => 'input',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'IndexedSequential' => {
        display_column => 'id',
        title          => 'Indexed Sequential',
        title_multi    => 'Indexed Sequentials',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          record_format => {
            header => 'record_format',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          record_length => {
            header => 'record_length',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          id => {
            header => 'id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          indices => {
            header => 'indices',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'InputOutput' => {
        display_column => 'name',
        title          => 'InputOutput',
        title_multi    => 'InputOutputs',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          io_type => {
            header => 'io_type',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          id => {
            header => 'id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          name => {
            header => 'name',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          uri => {
            header => 'uri',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          version => {
            header => 'version',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          library => {
            header => 'library',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          measure => {
            header => 'measure',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          record => {
            header => 'record',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          ddm => {
            header => 'ddm',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          dli_database => {
            header => 'dli_database',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          fieldtofields => {
            header => 'fieldtofields',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          flow_inputs => {
            header => 'flow_inputs',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          flows => {
            header => 'flows',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          indexed_sequential => {
            header => 'indexed_sequential',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          logical_physical_logicals => {
            header => 'logical_physical_logicals',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          logical_physical_physicals => {
            header => 'logical_physical_physicals',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          printer => {
            header => 'printer',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program_inputs => {
            header => 'program_inputs',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program_outputs => {
            header => 'program_outputs',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          rdbms_table => {
            header => 'rdbms_table',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          screen => {
            header => 'screen',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          sequential => {
            header => 'sequential',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'LogicalPhysical' => {

        #display_column => '',
        title        => 'Logical Physical',
        title_multi  => 'Logical Physicals',
        iconCls      => 'ra-icon-pg',
        multiIconCls => 'ra-icon-pg-multi',
        columns      => {
          logical => {
            header => 'logical',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          physical => {
            header => 'physical',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'Measure' => {
        display_column => 'id',
        title          => 'Measure',
        title_multi    => 'Measures',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          id => {
            header => 'id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          function_points => {
            header => 'function_points',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          loc => {
            header => 'loc',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          nonempty_loc => {
            header => 'nonempty_loc',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          version => {
            header => 'version',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          input_outputs => {
            header => 'input_outputs',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          programs => {
            header => 'programs',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'Printer' => {
        display_column => 'id',
        title          => 'Printer',
        title_multi    => 'Printers',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          id => {
            header => 'id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'Program' => {
        display_column => 'name',
        title          => 'Program',
        title_multi    => 'Programs',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          id => {
            header => 'id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          alias_name => {
            header => 'alias_name',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          dialect => {
            header => 'dialect',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          source_language => {
            header => 'source_language',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          modifier => {
            header => 'modifier',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          name => {
            header => 'name',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          uri => {
            header => 'uri',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          version => {
            header => 'version',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          library => {
            header => 'library',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          measure => {
            header => 'measure',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          dynamiccalls => {
            header => 'dynamiccalls',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program_call_programs => {
            header => 'program_call_programs',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program_calls_called => {
            header => 'program_calls_called',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program_errors => {
            header => 'program_errors',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program_flows => {
            header => 'program_flows',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program_inputs => {
            header => 'program_inputs',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program_outputs => {
            header => 'program_outputs',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program_statements => {
            header => 'program_statements',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program_using_programs => {
            header => 'program_using_programs',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          programs_using_used => {
            header => 'programs_using_used',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          working_storages => {
            header => 'working_storages',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'ProgramCall' => {
        display_column => 'called',
        title          => 'Program Call',
        title_multi    => 'Program Calls',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          id => {
            header => 'id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          version => {
            header => 'version',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          called => {
            header => 'called',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program => {
            header => 'program',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          statement_id => {
            header => 'statement_id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            profiles => [ 'hidden' ],
          },
          statement => {
            header => 'statement',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'ProgramError' => {
        display_column => 'program',
        title          => 'Program Error',
        title_multi    => 'Program Errors',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          id => {
            header => 'id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          line => {
            header => 'line',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          message => {
            header => 'message',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          position => {
            header => 'position',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program => {
            header => 'program',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'ProgramFlow' => {

        display_column => 'flow',
        title        => 'Program Flow',
        title_multi  => 'Program Flows',
        iconCls      => 'ra-icon-pg',
        multiIconCls => 'ra-icon-pg-multi',
        columns      => {
          program => {
            header => 'program',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          flow => {
            header => 'flow',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          succession => {
            header => 'succession',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'ProgramInput' => {

        display_column => 'input',
        title        => 'Program Input',
        title_multi  => 'Program Inputs',
        iconCls      => 'ra-icon-pg',
        multiIconCls => 'ra-icon-pg-multi',
        columns      => {
          program => {
            header => 'program',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          input => {
            header => 'input',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'ProgramOutput' => {

        display_column => 'output',
        title        => 'Program Output',
        title_multi  => 'Program Outputs',
        iconCls      => 'ra-icon-pg',
        multiIconCls => 'ra-icon-pg-multi',
        columns      => {
          output => {
            header => 'output',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program => {
            header => 'program',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          'program.program_flows' => {
            header => 'flows',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          'program.program_inputs' => {
            header => 'inputs',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          
        },
      },
      'ProgramStatement' => {
        display_column => 'id',
        title          => 'Program Statement',
        title_multi    => 'Program Statements',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          id => {
            header => 'id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program => {
            header => 'program',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          statement_id => {
            header => 'statement_id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            profiles => [ 'hidden' ],
          },
          statement => {
            header => 'statement',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'ProgramUsing' => {
        display_column => 'id',
        title          => 'Program Using',
        title_multi    => 'Program Usings',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          id => {
            header => 'id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          version => {
            header => 'version',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program => {
            header => 'program',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          statement_id => {
            header => 'statement_id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            profiles => [ 'hidden' ],
          },
          used => {
            header => 'used',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          statement => {
            header => 'statement',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'Screen' => {
        display_column => 'id',
        title          => 'Screen',
        title_multi    => 'Screens',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          id => {
            header => 'id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'Step' => {
        display_column => 'name',
        title          => 'Step',
        title_multi    => 'Steps',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          id => {
            header => 'id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          line => {
            header => 'line',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          name => {
            header => 'name',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          operation_type => {
            header => 'operation_type',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          transform => {
            header => 'transform',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          version => {
            header => 'version',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          flow => {
            header => 'flow',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          parent_step => {
            header => 'parent_step',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          result => {
            header => 'result',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          succession => {
            header => 'succession',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          step => {
            header => 'step',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          step_arguments => {
            header => 'step_arguments',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          step_conditions => {
            header => 'step_conditions',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          steps => {
            header => 'steps',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'StepArgument' => {

        #display_column => '',
        title        => 'Step Argument',
        title_multi  => 'Step Arguments',
        iconCls      => 'ra-icon-pg',
        multiIconCls => 'ra-icon-pg-multi',
        columns      => {
          step => {
            header => 'step',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          argument => {
            header => 'argument',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          succession => {
            header => 'succession',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'StepCondition' => {

        #display_column => '',
        title        => 'Step Condition',
        title_multi  => 'Step Conditions',
        iconCls      => 'ra-icon-pg',
        multiIconCls => 'ra-icon-pg-multi',
        columns      => {
          step_id => {
            header => 'step_id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            profiles => [ 'hidden' ],
          },
          conditions_id => {
            header => 'conditions_id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            profiles => [ 'hidden' ],
          },
          depth => {
            header => 'depth',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          condition => {
            header => 'condition',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          step => {
            header => 'step',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'Token' => {
        display_column => 'text',
        title          => 'Token',
        title_multi    => 'Tokens',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          id => {
            header => 'id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          column_of_line => {
            header => 'column_of_line',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          line => {
            header => 'line',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          text => {
            header => 'text',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          type => {
            header => 'type',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          typename => {
            header => 'typename',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          version => {
            header => 'version',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          parent => {
            header => 'parent',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          succession => {
            header => 'succession',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          dynamiccalls => {
            header => 'dynamiccalls',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program_calls => {
            header => 'program_calls',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program_statements => {
            header => 'program_statements',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          programs_using => {
            header => 'programs_using',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          step_condition => {
            header => 'step_condition',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          tokens => {
            header => 'tokens',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'Type' => {
        display_column => 'name',
        title          => 'Type',
        title_multi    => 'Types',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          record_type => {
            header => 'record_type',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          id => {
            header => 'id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          declared_level => {
            header => 'declared_level',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          name => {
            header => 'name',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          occurs => {
            header => 'occurs',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          precision => {
            header => 'precision',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          scale => {
            header => 'scale',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          type => {
            header => 'type',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          using_of_parameter => {
            header => 'using_of_parameter',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          version => {
            header => 'version',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          adabas_id => {
            header => 'adabas_id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          parent => {
            header => 'parent',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          physical => {
            header => 'physical',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          redefine => {
            header => 'redefine',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          succession => {
            header => 'succession',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          indice => {
            header => 'indice',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          input_outputs => {
            header => 'input_outputs',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          step_arguments => {
            header => 'step_arguments',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          steps => {
            header => 'steps',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          superdescriptor => {
            header => 'superdescriptor',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          type_parents => {
            header => 'type_parents',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          type_physicals => {
            header => 'type_physicals',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          type_redefines => {
            header => 'type_redefines',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          working_storages => {
            header => 'working_storages',
            #width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
      'VType' => {
        display_column => 'name',
        title          => 'V_Type',
        title_multi    => 'V_Types',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          record_type => {
            header => 'record_type',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          id => {
            header => 'id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          declared_level => {
            header => 'declared_level',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          name => {
            header => 'name',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          occurs => {
            header => 'occurs',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          precision => {
            header => 'precision',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          scale => {
            header => 'scale',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          type => {
            header => 'type',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          using_of_parameter => {
            header => 'using_of_parameter',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          version => {
            header => 'version',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          adabas_id => {
            header => 'adabas_id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          parent => {
            header => 'parent',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          physical => {
            header => 'physical',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          redefine => {
            header => 'redefine',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          succession => {
            header => 'succession',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        },
      },
    },
  },

);

=head1 NAME

AUApp::Model::DB - Catalyst/RapidApp DBIC Schema Model

=head1 SYNOPSIS

See L<AUApp>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<AUApp::DB>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema::ForRapidDbic - 0.65

=head1 AUTHOR

U-WIN\pgitzel,S-1-5-21-4186282176-3833931747-852283848-1105

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
