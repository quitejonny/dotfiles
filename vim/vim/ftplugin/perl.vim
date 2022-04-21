setlocal ts=4 sw=4 expandtab autoindent
setlocal textwidth=100
setlocal colorcolumn=+1
setlocal path+=lib
setlocal path+=$HOME/qwiki-repos/QwikiContrib/core/lib
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

call IMAP('around`', "around <+sub+> => sub {\<CR>my ( $orig, $class, <+args+> ) = @_;\<CR>\<CR>return $class->$orig(<+args+>);\<CR>};\<CR>", 'perl')
call IMAP('has`', "has <+attribute+> => (\<CR>is => '<+ro+>',\<CR>isa => <+isa+>\<CR>);\<CR>", 'perl')
call IMAP('use Moose`', "use Moose;\<CR><++>\<CR>\<CR>no Moose;\<CR>__PACKAGE__->meta->make_immutable;", 'perl')
call IMAP('use Exporter`', "use Exporter 'import';\<CR>our @EXPORT_OK = qw( <+module+> );\<CR>sub <+module+> { __PACKAGE__ }\<CR><++>", 'perl')
call IMAP('package`', "package <+package+>;\<CR><++>\<CR>\<CR>1;", 'perl')
call IMAP('package{`', "package <+package+> {\<CR><++>\<CR>\<CR>1;\<CR>};\<CR>", 'perl')
call IMAP('sub`', "sub <+name+> {\<CR>my ( $this<++> ) = @_;\<CR><++>\<CR>}", 'perl')
call IMAP('StackTrace`', "use Devel::StackTrace;\<CR>use Foswiki::Func ();\<CR>Foswiki::Func::writeWarning(Devel::StackTrace->new->as_string);\<CR>", 'perl')
call IMAP('describe`', "describe '<+description+>' => sub {\<CR><++>\<CR>};", 'perl')
call IMAP('it`', "it '<+description+>' => sub {\<CR><++>\<CR>};", 'perl')
call IMAP('use Test::Spec`', "use strict;\<CR>use warnings;\<CR>\<CR>use Test::Spec;\<CR>\<CR>describe '<+description+>' => sub {\<CR>it '<+description+>' => sub {\<CR><++>\<CR>};\<CR>};\<CR>\<CR>runtests unless caller;", 'perl')
call IMAP('use Moose::Exporter`', "use Moose::Exporter;\<CR>\<CR>Moose::Exporter->setup_import_methods( trait_aliases => [__PACKAGE__] );\<CR>", 'perl')
call IMAP('use Moose::Role`', "use Moose::Role;\<CR>use Moose::Exporter;\<CR>\<CR>Moose::Exporter->setup_import_methods( trait_aliases => [__PACKAGE__] );\<CR>\<CR>requires qw(<++> );\<CR>\<CR>no Moose::Role;", 'perl')
call IMAP('tableSpec`', "tableSpec <+sub+> => ({\<CR>value => <+value+>,\<CR>expected => <+expected+>,\<CR>});\<CR>", 'perl')
call IMAP('use Data::Dumper`', "use Data::Dumper;\<CR>print STDERR Dumper(<++>);\<CR>", 'perl')
