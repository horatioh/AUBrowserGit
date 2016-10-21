package AUApp::Model::Auswertung;


use strict;
use base 'Catalyst::Model::DBIC::Schema';

use DBI;
use File::Slurp;
use SQL::SplitStatement;

use Moose;
#use MooseX::Types::Moose qw/Str/;
#use MooseX::Types::LoadableClass qw/LoadableClass/;

	
has 'dateifeldzuordnung_script' => (is => 'rw', isa => 'Str');
has 'entry_level_input_script' => (is => 'rw', isa => 'Str');
has 'entry_level_output_script' => (is => 'rw', isa => 'Str');
has 'input_feld_2_feld_script' => (is => 'rw', isa => 'Str');
has 'output_feld_2_feld_script' => (is => 'rw', isa => 'Str');
has 'inputohneoutput_script' => (is => 'rw', isa => 'Str');
has 'outputohneinput_script' => (is => 'rw', isa => 'Str');


__PACKAGE__->config(
    schema_class => 'AUApp::Auswertung',
    dateifeldzuordnung_script => 'root/sql/au_fields/dateifeldzuordnung.sql',
    entry_level_input_script => 'root/sql/au_fields/entry_level_input.sql',
    entry_level_output_script => 'root/sql/au_fields/entry_level_output.sql',
    input_feld_2_feld_script => 'root/sql/au_fields/input_feld_2_feld_hierarchie.sql',
    output_feld_2_feld_script => 'root/sql/au_fields/output_feld_2_feld_hierarchie.sql',
    inputohneoutput_script => 'root/sql/au_fields/inputohneoutput.sql',
    outputohneinput_script => 'root/sql/au_fields/outputohneinput.sql',
    connect_info => {
        dsn => 'dbi:Pg:dbname=au;host=localhost;port=5432',
        user => 'au',
        password => 'Vienna',
        schema => 'au_extension',
    },
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
            save => { showtext => 1},
            undo => { showtext => 1 },
            
          }
        }
      },
      ## Parameter Table - Allow CRUD
      'AuExtensionFInputDatei' => {
      	grid_class  => 'AUApp::Module::GridBase',
        updatable_colspec   => ['*'],
        creatable_colspec   => ['*'],
        destroyable_relspec => ['*'],
        include_colspec => ['*', 'id.name']
      	
      },
      ## Parameter Table - Allow CRUD
      'AuExtensionFInputRecord' => {
      	grid_class  => 'AUApp::Module::GridBase',
        updatable_colspec   => ['*'],
        creatable_colspec   => ['*'],
        destroyable_relspec => ['*'],
      	
      },
      ## Parameter Table - Allow CRUD
      'AuExtensionFInputFeld' => {
      	grid_class  => 'AUApp::Module::GridBase',
        updatable_colspec   => ['*'],
        creatable_colspec   => ['*'],
        destroyable_relspec => ['*'],
      	
      },
      ## Parameter Table - Allow CRUD
      'AuExtensionFOutputDatei' => {
      	grid_class  => 'AUApp::Module::GridBase',
        updatable_colspec   => ['*'],
        creatable_colspec   => ['*'],
        destroyable_relspec => ['*'],
      	
      },
      ## Parameter Table - Allow CRUD
      'AuExtensionFOutputRecord' => {
      	grid_class  => 'AUApp::Module::GridBase',
        updatable_colspec   => ['*'],
        creatable_colspec   => ['*'],
        destroyable_relspec => ['*'],
      	
      },
      ## Parameter Table - Allow CRUD
      'AuExtensionFOutputFeld' => {
      	grid_class  => 'AUApp::Module::GridBase',
        updatable_colspec   => ['*'],
        creatable_colspec   => ['*'],
        destroyable_relspec => ['*'],
      	
      },
      ## Enable URIDbicPropPage as page class
      'AuExtensionEntryLevel' => {
      	grid_class  => 'AUApp::Module::GridBase',
        page_class  => 'AUApp::Module::UriDbicPropPage',
      	
      },
      ## Enable URIDbicPropPage as page class
      'AuExtensionEntryLevelOutput' => {
      	grid_class  => 'AUApp::Module::GridBase',
        page_class  => 'AUApp::Module::UriDbicPropPage',
      	
      },
       ## Enable URIDbicPropPage as page class
      'AuExtensionFInputOhneOutput' => {
      	grid_class  => 'AUApp::Module::GridBase',
        page_class  => 'AUApp::Module::UriDbicPropPage',
      	
      },
       ## Enable URIDbicPropPage as page class
      'AuExtensionFInputOutput' => {
      	grid_class  => 'AUApp::Module::GridBase',
        page_class  => 'AUApp::Module::UriDbicPropPage',
      	
      },
       ## Enable URIDbicPropPage as page class
      'AuExtensionFOutputOhneIntput' => {
      	grid_class  => 'AUApp::Module::GridBase',
        page_class  => 'AUApp::Module::UriDbicPropPage',
      	
      },
       ## Enable URIDbicPropPage as page class
      'AuExtensionFType' => {
      	grid_class  => 'AUApp::Module::GridBase',
        page_class  => 'AUApp::Module::UriDbicPropPage',
      	
      },
       ## Enable URIDbicPropPage as page class
      'AuExtensionInputAndOutputs' => {
      	grid_class  => 'AUApp::Module::GridBase',
        page_class  => 'AUApp::Module::UriDbicPropPage',
      	
      },
       ## Enable URIDbicPropPage as page class
      'AuExtensionNotUsedInputOutput' => {
      	grid_class  => 'AUApp::Module::GridBase',
        page_class  => 'AUApp::Module::UriDbicPropPage',
      	
      },
       ## Enable URIDbicPropPage as page class
      'AuExtensionOnlyInput' => {
      	grid_class  => 'AUApp::Module::GridBase',
        page_class  => 'AUApp::Module::UriDbicPropPage',
      	
      },
       ## Enable URIDbicPropPage as page class
      'AuExtensionOnlyOutput' => {
      	grid_class  => 'AUApp::Module::GridBase',
        page_class  => 'AUApp::Module::UriDbicPropPage',
      	
      },
      
      
    },
    TableSpecs => {
      'AuExtensionEntryLevel' => {
#        display_column => 'name',
        title          => 'Entry Level',
        title_multi    => 'Entry Levels',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          input_feld_id => {
            header => 'inputfeld id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_id => {
            header => 'datei id',
            width => 80,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_name => {
            header => 'datei name',
            width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_type => {
            header => 'datei type',
            #no_column => 1,
            width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_recordid => {
            header => 'datei recordid',
            no_column => 1,
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_parent => {
            header => 'datei parent',
            no_column => 1,
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_succession => {
            header => 'datei succession',
            width => 50,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_precision => {
            header => 'datei precision',
            width => 100,
            no_column => 1,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_id => {
            header => 'record id',
            width => 80,
            no_column => 1,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_name => {
            header => 'record name',
            width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_type => {
            header => 'record type',
            width => 100,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_parent => {
            header => 'record parent',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_succession => {
            header => 'record succession',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_precision => {
            header => 'record precision',
            width => 50,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_id => {
            header => 'field id',
            width => 80,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_name => {
            header => 'field name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_type => {
            header => 'field type',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_parent => {
            header => 'field parent',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_succession => {
            header => 'field succession',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_precision => {
            header => 'field precision',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          io_uri => {
            header => 'source uri',
            width => 500,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },           
### 
          }, ### End of Columns
        }, ### End of Table
        
      'AuExtensionEntryLevelOutput' => {
#        display_column => 'name',
        title          => 'Entry Level Output',
        title_multi    => 'Entry Level Outputs',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          output_feld_id => {
            header => 'outputfeld id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_id => {
            header => 'datei id',
            width => 80,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_name => {
            header => 'datei name',
            width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_type => {
            header => 'datei type',
            #no_column => 1,
            width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_recordid => {
            header => 'datei recordid',
            no_column => 1,
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_parent => {
            header => 'datei parent',
            no_column => 1,
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_succession => {
            header => 'datei succession',
            width => 50,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_precision => {
            header => 'datei precision',
            width => 100,
            no_column => 1,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_id => {
            header => 'record id',
            width => 80,
            no_column => 1,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_name => {
            header => 'record name',
            width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_type => {
            header => 'record type',
            width => 100,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_parent => {
            header => 'record parent',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_succession => {
            header => 'record succession',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_precision => {
            header => 'record precision',
            width => 50,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_id => {
            header => 'field id',
            width => 80,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_name => {
            header => 'field name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_type => {
            header => 'field type',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_parent => {
            header => 'field parent',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_succession => {
            header => 'field succession',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_precision => {
            header => 'field precision',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          io_uri => {
            header => 'source uri',
            width => 500,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },           
### 
          }, ### End of Columns
        }, ### End of Table

      'AuExtensionExcludePgm' => {
#        display_column => 'name',
        title          => 'Exclude Program',
        title_multi    => 'Exclude Programs',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          id => {
            header => 'program id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
 ### 
          }, ### End of Columns
        }, ### End of Table

      'AuExtensionFFieldtofieldOutputResult' => {
#        display_column => 'name',
        title          => 'Field to Field Output Result',
        title_multi    => 'Field to Field Output Results',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          level => {
            header => 'level',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          output_feld_id => {
            header => 'output feld id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          output_feld_name => {
            header => 'output feld name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program_name => {
            header => 'program name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          flow_id => {
            header => 'flow id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          input_id => {
            header => 'input id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          input_file_name => {
            header => 'input file name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          source_id => {
            header => 'source id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          source_feld_name => {
            header => 'source feld name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          target_id => {
            header => 'target id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          target_feld_name => {
            header => 'target feld name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
 ### 
          }, ### End of Columns
        }, ### End of Table

      'AuExtensionFFieldtofieldResult' => {
#        display_column => 'name',
        title          => 'Field to Field Result',
        title_multi    => 'Field to Field Results',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          level => {
            header => 'level',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          input_feld_id => {
            header => 'input feld id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          input_feld_name => {
            header => 'input feld name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          program_name => {
            header => 'program name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          flow_id => {
            header => 'flow id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          input_id => {
            header => 'input id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          input_file_name => {
            header => 'input file name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          source_id => {
            header => 'source id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          source_feld_name => {
            header => 'source feld name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          target_id => {
            header => 'target id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          target_feld_name => {
            header => 'target feld name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
 ### 
          }, ### End of Columns
        }, ### End of Table

      'AuExtensionFInputDatei' => {
#        display_column => 'name',
        title          => 'F Input Datei',
        title_multi    => 'F Input Dateien',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          id => {
            header => 'inputoutput id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
 ### 
          }, ### End of Columns
        }, ### End of Table

      'AuExtensionFInputFeld' => {
#        display_column => 'name',
        title          => 'F Input Feld',
        title_multi    => 'F Input Feld',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          id => {
            header => 'Feld id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
 ### 
          }, ### End of Columns
        }, ### End of Table

      'AuExtensionFInputFelder' => {
#        display_column => 'name',
        title          => 'Analyse Input Felder',
        title_multi    => 'Analyse Input Felder',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          id => {
            header => 'Felder id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
 ### 
          }, ### End of Columns
        }, ### End of Table

      'AuExtensionFInputOhneOutput' => {
#        display_column => 'name',
        title          => 'Input ohne Output',
        title_multi    => 'Input ohne Outputs',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          input_feld_id => {
            header => 'inputfeld id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_id => {
            header => 'datei id',
            width => 80,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_name => {
            header => 'datei name',
            width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_type => {
            header => 'datei type',
            #no_column => 1,
            width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_recordid => {
            header => 'datei recordid',
            no_column => 1,
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_parent => {
            header => 'datei parent',
            no_column => 1,
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_succession => {
            header => 'datei succession',
            width => 50,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_precision => {
            header => 'datei precision',
            width => 100,
            no_column => 1,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_id => {
            header => 'record id',
            width => 80,
            no_column => 1,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_name => {
            header => 'record name',
            width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_type => {
            header => 'record type',
            width => 100,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_parent => {
            header => 'record parent',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_succession => {
            header => 'record succession',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_precision => {
            header => 'record precision',
            width => 50,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_id => {
            header => 'field id',
            width => 80,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_name => {
            header => 'field name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_type => {
            header => 'field type',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_parent => {
            header => 'field parent',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_succession => {
            header => 'field succession',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_precision => {
            header => 'field precision',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          io_uri => {
            header => 'source uri',
            width => 500,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          }, 
          l1_flow_id => {
            header => 'l1_flow_id',
            width => 50,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          l1_input_id => {
            header => 'l1_input_id',
            width => 50,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          l1_source_id => {
            header => 'l1_source_id',
            width => 50,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          l1_target_id => {
            header => 'l1_target_id',
            width => 50,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },                    
### 
          }, ### End of Columns
        }, ### End of Table

      'AuExtensionFInputOutput' => {
#        display_column => 'name',
        title          => 'F Input Output',
        title_multi    => 'F Input Outputs',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          io_id => {
            header => 'IO id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          io_name => {
            header => 'IO name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          io_iotype => {
            header => 'IO type',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          io_recordid => {
            header => 'IO recordid',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          io_uri => {
            header => 'IO uri',
            width => 500,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },          
 ### 
          }, ### End of Columns
        }, ### End of Table

      'AuExtensionFInputRecord' => {
#        display_column => 'name',
        title          => 'F Input Record',
        title_multi    => 'F Input Records',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          id => {
            header => 'Input Record id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
 ### 
          }, ### End of Columns
        }, ### End of Table

      'AuExtensionFOutputDatei' => {
#        display_column => 'name',
        title          => 'F Output Datei',
        title_multi    => 'F Output Dateien',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          id => {
            header => 'Output Datei id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
 ### 
          }, ### End of Columns
        }, ### End of Table

      'AuExtensionFOutputFeld' => {
#        display_column => 'name',
        title          => 'F Output Feld',
        title_multi    => 'F Output Feld',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          id => {
            header => 'Output Feld id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
 ### 
          }, ### End of Columns
        }, ### End of Table

      'AuExtensionFOutputFelder' => {
#        display_column => 'name',
        title          => 'Analyse Output Felder',
        title_multi    => 'Analyse Output Felder',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          id => {
            header => 'Output Felder id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
 ### 
          }, ### End of Columns
        }, ### End of Table

      'AuExtensionFOutputOhneIntput' => {
#        display_column => 'name',
        title          => 'Output ohne Input',
        title_multi    => 'Output ohne Inputs',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          output_feld_id => {
            header => 'inputfeld id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_id => {
            header => 'datei id',
            width => 80,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_name => {
            header => 'datei name',
            width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_type => {
            header => 'datei type',
            #no_column => 1,
            width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_recordid => {
            header => 'datei recordid',
            no_column => 1,
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_parent => {
            header => 'datei parent',
            no_column => 1,
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_succession => {
            header => 'datei succession',
            width => 50,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_precision => {
            header => 'datei precision',
            width => 100,
            no_column => 1,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_id => {
            header => 'record id',
            width => 80,
            no_column => 1,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_name => {
            header => 'record name',
            width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_type => {
            header => 'record type',
            width => 100,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_parent => {
            header => 'record parent',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_succession => {
            header => 'record succession',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_precision => {
            header => 'record precision',
            width => 50,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_id => {
            header => 'field id',
            width => 80,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_name => {
            header => 'field name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_type => {
            header => 'field type',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_parent => {
            header => 'field parent',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_succession => {
            header => 'field succession',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_precision => {
            header => 'field precision',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          io_uri => {
            header => 'source uri',
            width => 500,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          }, 
          l1_flow_id => {
            header => 'l1_flow_id',
            width => 50,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          l1_input_id => {
            header => 'l1_input_id',
            width => 50,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          l1_source_id => {
            header => 'l1_source_id',
            width => 50,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          l1_target_id => {
            header => 'l1_target_id',
            width => 50,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },                    
### 
          }, ### End of Columns
        }, ### End of Table

      'AuExtensionFOutputRecord' => {
#        display_column => 'name',
        title          => 'F Output Record',
        title_multi    => 'F Output Records',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          id => {
            header => 'Output Record id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
 ### 
          }, ### End of Columns
        }, ### End of Table

      'AuExtensionFType' => {
#        display_column => 'name',
        title          => 'F Type',
        title_multi    => 'F Types',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          d_id => {
            header => 'datei id',
            width => 80,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_name => {
            header => 'datei name',
            width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_type => {
            header => 'datei type',
            #no_column => 1,
            width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_recordid => {
            header => 'datei recordid',
            no_column => 1,
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_parent => {
            header => 'datei parent',
            no_column => 1,
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_succession => {
            header => 'datei succession',
            width => 50,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          d_precision => {
            header => 'datei precision',
            width => 100,
            no_column => 1,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_id => {
            header => 'record id',
            width => 80,
            no_column => 1,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_name => {
            header => 'record name',
            width => 100,
            #sortable => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_type => {
            header => 'record type',
            width => 100,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_parent => {
            header => 'record parent',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_succession => {
            header => 'record succession',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          r_precision => {
            header => 'record precision',
            width => 50,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_id => {
            header => 'field id',
            width => 80,
            no_column => 1,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_name => {
            header => 'field name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_type => {
            header => 'field type',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_parent => {
            header => 'field parent',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_succession => {
            header => 'field succession',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          f_precision => {
            header => 'field precision',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          io_uri => {
            header => 'source uri',
            width => 500,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          }, 
### 
          }, ### End of Columns
        }, ### End of Table

      'AuExtensionInputAndOutputs' => {
#        display_column => 'name',
        title          => 'Inputs and Outputs',
        title_multi    => 'Inputs and Outputs',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          io_type => {
            header => 'io_type',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          id => {
            header => 'id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          name => {
            header => 'name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          uri => {
            header => 'uri',
            width => 500,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },          
           version => {
            header => 'version',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
           library => {
            header => 'library',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
           measure => {
            header => 'measure',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
            record => {
            header => 'record',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
 
 ### 
          }, ### End of Columns
        }, ### End of Table

      'AuExtensionLAll' => {
#        display_column => 'name',
        title          => 'L All',
        title_multi    => 'L All',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          level => {
            header => 'level',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          output_feld_id => {
            header => 'output feld id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          flow_id => {
            header => 'flow id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          input_id => {
            header => 'input id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },          
           source_id => {
            header => 'source id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
           target_id => {
            header => 'target id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
 ### 
          }, ### End of Columns
        }, ### End of Table

      'AuExtensionNotUsedInputOutput' => {
#        display_column => 'name',
        title          => 'Not used InputOutput',
        title_multi    => 'Not used InputOutputs',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          io_type => {
            header => 'io_type',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          id => {
            header => 'id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          name => {
            header => 'name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          uri => {
            header => 'uri',
            width => 500,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },          
           version => {
            header => 'version',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
           library => {
            header => 'library',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
           measure => {
            header => 'measure',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
            record => {
            header => 'record',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },

          }, ### End of Columns
        }, ### End of Table
 
       'AuExtensionOnlyInput' => {
#        display_column => 'name',
        title          => 'Only Input',
        title_multi    => 'Only Inputs',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          io_type => {
            header => 'io_type',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          id => {
            header => 'id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          name => {
            header => 'name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          uri => {
            header => 'uri',
            width => 500,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },          
           version => {
            header => 'version',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
           library => {
            header => 'library',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
           measure => {
            header => 'measure',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
            record => {
            header => 'record',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
 ### 
          }, ### End of Columns
        }, ### End of Table

       'AuExtensionOnlyOutput' => {
#        display_column => 'name',
        title          => 'Only Output',
        title_multi    => 'Only Outputs',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
###
          io_type => {
            header => 'io_type',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          id => {
            header => 'id',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          name => {
            header => 'name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          uri => {
            header => 'uri',
            width => 500,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },          
           version => {
            header => 'version',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
           library => {
            header => 'library',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
           measure => {
            header => 'measure',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
            record => {
            header => 'record',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
 ### 
          }, ### End of Columns
        }, ### End of Table

      'AuExtensionVInputOutput' => {
        display_column => 'name',
        title          => 'V InputOutput',
        title_multi    => 'V InputOutputs',
        iconCls        => 'ra-icon-pg',
        multiIconCls   => 'ra-icon-pg-multi',
        columns        => {
          io_type => {
            header => 'io_type',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          id => {
            header => 'id',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          name => {
            header => 'name',
            width => 80,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          uri => {
            header => 'uri',
            width => 400,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          version => {
            header => 'version',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            profiles => ['hidden' ],
          },
          library => {
            header => 'library',
            width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
          measure => {
            header => 'measure',
            width => 50,
            #renderer => 'RA.ux.App.someJsFunc',
            profiles => ['hidden' ],
          },
          record => {
            header => 'record',
            width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            #profiles => [],
          },
        }, ### End of Columns
      }, ### End of Table
      
      'AuExtensionVFieldtofield' => {
#        display_column => 'id',
        title          => 'V Field to field',
        title_multi    => 'V Field to fields',
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
            #no_column => 1,
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            profiles => [ ],
          },
          target_id => {
            header => 'target',
            #no_column => 1,
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            profiles => [  ],
          },
          flow_id => {
            header => 'flow_id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            profiles => [ ],
          },
          input_id => {
            header => 'input_id',
            #width => 100,
            #renderer => 'RA.ux.App.someJsFunc',
            profiles => [ ],
          },
        }, ### End of Columns
      }, ### End of Table

      'AuExtensionVProgram' => {
        display_column => 'name',
        title          => 'V Program',
        title_multi    => 'V Programs',
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
        }, ### End of Columns
      }, ### End of Table

      'AuExtensionVType' => {
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
        }, ### End of Columns
      }, ### End of Table 
      

        
      }, ### End of TableSpecs  
  }, ### End of RapidDbic
); ### End of Config

=head1 NAME

AUApp::Model::Auswertung - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<AUApp>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<AUApp::Auswertung>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.65

=head1 AUTHOR

U-GROUPINFRA\gitzelp,S-1-5-21-3641078771-3653456904-245653651-141386

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

sub run_sql_script  {
	my ($self, $c, $script)= @_;
$DB::single=1;
	my $connect_dsn = $self->connect_info->{dsn};
	my $connect_user = $self->connect_info->{user};
	my $connect_password = $self->connect_info->{password};
	my $schema = $self->connect_info->{schema};
	my $sql_error = 0;
	
	
	$c->log->debug("Run_sql_script called");
	my $sql_blob = read_file( $script ) or $c->log->error( "Error reading SQL script: $script" );
	my @sql_list = SQL::SplitStatement->new()->split($sql_blob);
	
	my $dbh = DBI->connect( $connect_dsn, $connect_user , $connect_password, {
        PrintError => 1,
        RaiseError => 1,
        AutoCommit => 0
  });
    $c->log->debug("SQL Execute:  set search_path to $schema");
    eval {
	  	$dbh->do("set search_path to $schema");
  	};
## If eval went wrong
  	if ($@)  {
  		$c->log->error( $dbh->errstr );
  		$sql_error = 1;
  		return 0;
  	}
  	$c->log->debug("Processing Script: $script"); 
  	eval {
		foreach my $sql (@sql_list) {
		  $c->log->debug("SQL Execute:  $sql");
		  $dbh->do($sql);
		}
		## Commit after script finished without errors
		$c->log->debug("Commiting changes to DB");
		$dbh->commit();
	};
## If eval went wrong
	if ($@)  {
  		$c->log->error( $dbh->errstr );
  		$c->log->debug("Rolling Back Transactions!");
  		$dbh->rollback();
  		$sql_error = 1;
  		return 0;
  	}
	return 1; 
}

sub run_sql_dateifeldzuordnung {
	my ($self, $c, $script)= @_;
	my $script = $self->dateifeldzuordnung_script;
	my $pwd = `pwd`;
	
	$c->log->debug("Run_sql_dateifeldzuordnung called with Pwd: $pwd script: $script");
	$self->run_sql_script($c, $script);
}
sub run_sql_entry_level_input {
	my ($self, $c, $script)= @_;
	my $script = $self->entry_level_input_script;
	my $pwd = `pwd`;
	
	$c->log->debug("Run_sql_entry_level_input called with Pwd: $pwd script: $script");
	$self->run_sql_script($c, $script);
}
sub run_sql_entry_level_output {
	my ($self, $c, $script)= @_;
	my $script = $self->entry_level_output_script;
	my $pwd = `pwd`;
	
	$c->log->debug("Run_sql_entry_level_output called with Pwd: $pwd script: $script");
	$self->run_sql_script($c, $script);
}
sub run_sql_input_feld_2_feld {
	my ($self, $c, $script)= @_;
	my $script = $self->input_feld_2_feld_script;
	my $pwd = `pwd`;
	
	$c->log->debug("Run_sql_input_feld_2_feld called with Pwd: $pwd script: $script");
	$self->run_sql_script($c, $script);
}
no Moose;
sub run_sql_output_feld_2_feld {
	my ($self, $c, $script)= @_;
	my $script = $self->output_feld_2_feld_script;
	my $pwd = `pwd`;
	
	$c->log->debug("Run_sql_output_feld_2_feld called with Pwd: $pwd script: $script");
	$self->run_sql_script($c, $script);
}
sub run_sql_inputohneoutput {
	my ($self, $c, $script)= @_;
	my $script = $self->inputohneoutput_script;
	my $pwd = `pwd`;
	
	$c->log->debug("Run_sql_inputohneoutput called with Pwd: $pwd script: $script");
	$self->run_sql_script($c, $script);
}
sub run_sql_outputohneinput {
	my ($self, $c, $script)= @_;
	my $script = $self->outputohneinput_script;
	my $pwd = `pwd`;
	
	$c->log->debug("Run_sql_outputohneinput called with Pwd: $pwd script: $script");
	$self->run_sql_script($c, $script);
}
__PACKAGE__->meta->make_immutable;	
1;
