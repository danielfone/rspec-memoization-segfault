Summary
-------

If Rspec's memoized helpers are infintely recursive, they'll cause a segfault in ruby >= 2.1.
Normal infinite recursion will cause the expected "SystemStackError: stack level too deep".

Steps
-----

1. Use recursion in a memoized helper
2. Write expectation using helper (see recursion_spec.rb)
3. Run spec

Expected Result
---------------

The recursion should trigger a SystemStackError and the spec should pass. e.g.

    $ rspec recursion_spec.rb -fd
    
    A recursive memoized helper
      should raise SystemStackError: stack level too deep
    
    Finished in 0.00658 seconds
    1 example, 0 failures

Actual Result
-------------

    ruby-1.9.3-p448         [pass]
    ruby-2.0.0-p247         [pass]
    ruby-2.1.0-p0           [segfault]
    ruby-2.1.1-p76          [segfault]

Both rspec 2.14.1 and 3.0.0.beta2 exhibit the same behaviour.

Full Output of Seg Fault
------------------------

    $ rspec recursion_spec.rb 
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb:239: [BUG] Segmentation fault at 0x007fff5afbcff8
    ruby 2.1.1p76 (2014-02-24 revision 45161) [x86_64-darwin13.0]
    
    -- Crash Report log information --------------------------------------------
       See Crash Report log file under the one of following:
         * ~/Library/Logs/CrashReporter
         * /Library/Logs/CrashReporter
         * ~/Library/Logs/DiagnosticReports
         * /Library/Logs/DiagnosticReports
       for more details.
    
    -- Control frame information -----------------------------------------------
    c:6253 p:0000 s:21896 e:001895 LAMBDA /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb:239 [FINISH]
    c:6252 p:0007 s:21894 e:001893 LAMBDA /Users/danielfone/Development/rspec-double-segfault/recursion_spec.rb:4 [FINISH]
    c:6251 p:0015 s:21892 e:001888 BLOCK  /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb:239 [FINISH]
    c:6250 p:---- s:21886 e:001885 CFUNC  :fetch
    c:6249 p:0011 s:21882 e:001881 LAMBDA /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb:239 [FINISH]
    c:6248 p:0007 s:21880 e:001879 LAMBDA /Users/danielfone/Development/rspec-double-segfault/recursion_spec.rb:4 [FINISH]
    c:6247 p:0015 s:21878 e:001874 BLOCK  /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb:239 [FINISH]
    [...]
    c:0022 p:---- s:0088 e:000087 CFUNC  :fetch
    c:0021 p:0011 s:0084 e:000083 LAMBDA /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb:239 [FINISH]
    c:0020 p:0013 s:0082 e:000079 BLOCK  /Users/danielfone/Development/rspec-double-segfault/recursion_spec.rb:7 [FINISH]
    c:0019 p:---- s:0078 e:000077 CFUNC  :instance_exec
    c:0018 p:0021 s:0074 e:000073 BLOCK  /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/example.rb:124
    c:0017 p:0015 s:0071 e:000070 METHOD /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/example.rb:274
    c:0016 p:0076 s:0066 E:0001c0 METHOD /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/example.rb:121
    c:0015 p:0048 s:0060 e:000059 BLOCK  /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/example_group.rb:468 [FINISH]
    c:0014 p:---- s:0055 e:000054 CFUNC  :map
    c:0013 p:0014 s:0052 e:000051 METHOD /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/example_group.rb:464
    c:0012 p:0068 s:0048 e:000047 METHOD /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/example_group.rb:431
    c:0011 p:0010 s:0041 e:000040 BLOCK  /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/command_line.rb:27 [FINISH]
    c:0010 p:---- s:0038 e:000037 CFUNC  :map
    c:0009 p:0027 s:0035 e:000034 BLOCK  /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/command_line.rb:27
    c:0008 p:0017 s:0032 e:000031 METHOD /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/reporter.rb:47
    c:0007 p:0074 s:0028 e:000027 METHOD /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/command_line.rb:24
    c:0006 p:0094 s:0023 e:000022 METHOD /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/runner.rb:100
    c:0005 p:0024 s:0016 e:000015 METHOD /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/runner.rb:31
    c:0004 p:0023 s:0012 e:000011 TOP    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/exe/rspec:4 [FINISH]
    c:0003 p:---- s:0010 e:000009 CFUNC  :load
    c:0002 p:0135 s:0006 E:0014c8 EVAL   /Users/danielfone/.gem/ruby/2.1.1/bin/rspec:23 [FINISH]
    c:0001 p:0000 s:0002 E:001908 TOP    [FINISH]
    
    /Users/danielfone/.gem/ruby/2.1.1/bin/rspec:23:in `<main>'
    /Users/danielfone/.gem/ruby/2.1.1/bin/rspec:23:in `load'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/exe/rspec:4:in `<top (required)>'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/runner.rb:31:in `invoke'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/runner.rb:100:in `run'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/command_line.rb:24:in `run'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/reporter.rb:47:in `report'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/command_line.rb:27:in `block in run'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/command_line.rb:27:in `map'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/command_line.rb:27:in `block (2 levels) in run'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/example_group.rb:431:in `run'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/example_group.rb:464:in `run_examples'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/example_group.rb:464:in `map'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/example_group.rb:468:in `block in run_examples'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/example.rb:121:in `run'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/example.rb:274:in `with_around_each_hooks'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/example.rb:124:in `block in run'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/example.rb:124:in `instance_exec'
    /Users/danielfone/Development/rspec-double-segfault/recursion_spec.rb:7:in `block (2 levels) in <top (required)>'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb:239:in `block in let'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb:239:in `fetch'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb:239:in `block (2 levels) in let'
    /Users/danielfone/Development/rspec-double-segfault/recursion_spec.rb:4:in `block (2 levels) in <top (required)>'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb:239:in `block in let'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb:239:in `fetch'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb:239:in `block (2 levels) in let'
    /Users/danielfone/Development/rspec-double-segfault/recursion_spec.rb:4:in `block (2 levels) in <top (required)>'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb:239:in `block in let'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb:239:in `fetch'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb:239:in `block (2 levels) in let'
    [...]
    /Users/danielfone/Development/rspec-double-segfault/recursion_spec.rb:4:in `block (2 levels) in <top (required)>'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb:239:in `block in let'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb:239:in `fetch'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb:239:in `block (2 levels) in let'
    /Users/danielfone/Development/rspec-double-segfault/recursion_spec.rb:4:in `block (2 levels) in <top (required)>'
    /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb:239:in `block in let'
    
    -- C level backtrace information -------------------------------------------
    0   ruby                                0x00000001046040fb rb_vm_bugreport + 251
    1   ruby                                0x000000010448a2a5 report_bug + 357
    2   ruby                                0x000000010448a5cf rb_bug + 207
    3   ruby                                0x000000010457740f sigsegv + 207
    4   libsystem_platform.dylib            0x00007fff9171e5aa _sigtramp + 26
    5   ruby                                0x00000001045e6eec vm_exec_core + 12
    6   ???                                 0x00007f902a93cff0 0x0 + 140257166348272
    
    -- Other runtime information -----------------------------------------------
    
    * Loaded script: /Users/danielfone/.gem/ruby/2.1.1/bin/rspec
    
    * Loaded features:
    
        0 enumerator.so
        1 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/x86_64-darwin13.0/enc/encdb.bundle
        2 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/x86_64-darwin13.0/enc/trans/transdb.bundle
        3 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/x86_64-darwin13.0/rbconfig.rb
        4 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/rubygems/compatibility.rb
        5 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/rubygems/defaults.rb
        6 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/rubygems/deprecate.rb
        7 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/rubygems/errors.rb
        8 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/rubygems/version.rb
        9 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/rubygems/requirement.rb
       10 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/rubygems/platform.rb
       11 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/rubygems/basic_specification.rb
       12 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/rubygems/stub_specification.rb
       13 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/rubygems/util/stringio.rb
       14 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/rubygems/specification.rb
       15 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/rubygems/exceptions.rb
       16 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/rubygems/core_ext/kernel_gem.rb
       17 thread.rb
       18 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/x86_64-darwin13.0/thread.bundle
       19 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/monitor.rb
       20 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/rubygems/core_ext/kernel_require.rb
       21 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/rubygems.rb
       22 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/rubygems/dependency.rb
       23 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/rubygems/path_support.rb
       24 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/set.rb
       25 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/x86_64-darwin13.0/date_core.bundle
       26 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/date/format.rb
       27 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/date.rb
       28 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/time.rb
       29 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/version.rb
       30 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-support-3.0.0.beta2/lib/rspec/support/caller_filter.rb
       31 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/warnings.rb
       32 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-support-3.0.0.beta2/lib/rspec/support/warnings.rb
       33 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/flat_map.rb
       34 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/filter_manager.rb
       35 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/dsl.rb
       36 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/formatters/helpers.rb
       37 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/notifications.rb
       38 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/reporter.rb
       39 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/hooks.rb
       40 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/memoized_helpers.rb
       41 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/metadata.rb
       42 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/pending.rb
       43 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/x86_64-darwin13.0/stringio.bundle
       44 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/formatters/legacy_formatter.rb
       45 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/formatters.rb
       46 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/ordering.rb
       47 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/world.rb
       48 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/x86_64-darwin13.0/etc.bundle
       49 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/fileutils.rb
       50 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/backtrace_formatter.rb
       51 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/x86_64-darwin13.0/pathname.bundle
       52 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/pathname.rb
       53 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/ruby_project.rb
       54 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/formatters/deprecation_formatter.rb
       55 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/configuration.rb
       56 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/optparse.rb
       57 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/option_parser.rb
       58 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/cgi/util.rb
       59 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/x86_64-darwin13.0/strscan.bundle
       60 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/erb.rb
       61 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/shellwords.rb
       62 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/configuration_options.rb
       63 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/command_line.rb
       64 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/runner.rb
       65 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/example.rb
       66 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/shared_example_group/collection.rb
       67 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/shared_example_group.rb
       68 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/example_group.rb
       69 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core.rb
       70 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-3.0.0.beta2/lib/rspec/version.rb
       71 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-3.0.0.beta2/lib/rspec.rb
       72 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/instance_method_stasher.rb
       73 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/method_double.rb
       74 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/argument_matchers.rb
       75 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/object_reference.rb
       76 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/example_methods.rb
       77 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/proxy.rb
       78 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/test_double.rb
       79 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-support-3.0.0.beta2/lib/rspec/support/fuzzy_matcher.rb
       80 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/argument_list_matcher.rb
       81 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/message_expectation.rb
       82 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/order_group.rb
       83 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/error_generator.rb
       84 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/space.rb
       85 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/extensions/marshal.rb
       86 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/any_instance/chain.rb
       87 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/any_instance/stub_chain.rb
       88 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/any_instance/stub_chain_chain.rb
       89 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/any_instance/expect_chain_chain.rb
       90 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/any_instance/expectation_chain.rb
       91 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/any_instance/message_chains.rb
       92 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/any_instance/recorder.rb
       93 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/mutate_const.rb
       94 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/matchers/have_received.rb
       95 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/matchers/receive.rb
       96 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/matchers/receive_messages.rb
       97 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/matchers/receive_message_chain.rb
       98 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/message_chain.rb
       99 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/targets.rb
      100 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/syntax.rb
      101 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/configuration.rb
      102 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/ruby_features.rb
      103 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/method_signature_verifier.rb
      104 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/verifying_message_expecation.rb
      105 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/method_reference.rb
      106 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/verifying_proxy.rb
      107 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/verifying_double.rb
      108 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/framework.rb
      109 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks/version.rb
      110 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-support-3.0.0.beta2/lib/rspec/support/version.rb
      111 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-support-3.0.0.beta2/lib/rspec/support.rb
      112 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-mocks-3.0.0.beta2/lib/rspec/mocks.rb
      113 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/mocking_adapters/rspec.rb
      114 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-expectations-3.0.0.beta2/lib/rspec/matchers/pretty.rb
      115 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-expectations-3.0.0.beta2/lib/rspec/matchers/composable.rb
      116 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-expectations-3.0.0.beta2/lib/rspec/matchers/built_in/base_matcher.rb
      117 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-expectations-3.0.0.beta2/lib/rspec/matchers/built_in.rb
      118 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-expectations-3.0.0.beta2/lib/rspec/matchers/generated_descriptions.rb
      119 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-expectations-3.0.0.beta2/lib/rspec/matchers/dsl.rb
      120 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-expectations-3.0.0.beta2/lib/rspec/matchers/matcher_delegator.rb
      121 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-expectations-3.0.0.beta2/lib/rspec/matchers/aliased_matcher.rb
      122 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-expectations-3.0.0.beta2/lib/rspec/matchers.rb
      123 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-expectations-3.0.0.beta2/lib/rspec/expectations/expectation_target.rb
      124 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-expectations-3.0.0.beta2/lib/rspec/expectations/syntax.rb
      125 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-expectations-3.0.0.beta2/lib/rspec/matchers/configuration.rb
      126 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-expectations-3.0.0.beta2/lib/rspec/expectations/fail_with.rb
      127 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-expectations-3.0.0.beta2/lib/rspec/expectations/handler.rb
      128 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-expectations-3.0.0.beta2/lib/rspec/expectations/version.rb
      129 /Users/danielfone/.gem/ruby/2.1.1/gems/diff-lcs-1.2.5/lib/diff/lcs/change.rb
      130 /Users/danielfone/.gem/ruby/2.1.1/gems/diff-lcs-1.2.5/lib/diff/lcs/callbacks.rb
      131 /Users/danielfone/.gem/ruby/2.1.1/gems/diff-lcs-1.2.5/lib/diff/lcs/internals.rb
      132 /Users/danielfone/.gem/ruby/2.1.1/gems/diff-lcs-1.2.5/lib/diff/lcs.rb
      133 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/delegate.rb
      134 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-expectations-3.0.0.beta2/lib/rspec/expectations/encoded_string.rb
      135 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-expectations-3.0.0.beta2/lib/rspec/expectations/differ.rb
      136 /Users/danielfone/.gem/ruby/2.1.1/gems/diff-lcs-1.2.5/lib/diff/lcs/block.rb
      137 /Users/danielfone/.gem/ruby/2.1.1/gems/diff-lcs-1.2.5/lib/diff/lcs/hunk.rb
      138 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/prettyprint.rb
      139 /Users/danielfone/.rubies/ruby-2.1.1/lib/ruby/2.1.0/pp.rb
      140 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-expectations-3.0.0.beta2/lib/rspec/expectations/diff_presenter.rb
      141 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-expectations-3.0.0.beta2/lib/rspec/expectations.rb
      142 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/formatters/base_formatter.rb
      143 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/formatters/base_text_formatter.rb
      144 /Users/danielfone/.gem/ruby/2.1.1/gems/rspec-core-3.0.0.beta2/lib/rspec/core/formatters/progress_formatter.rb
    
    [NOTE]
    You may have encountered a bug in the Ruby interpreter or extension libraries.
    Bug reports are welcome.
    For details: http://www.ruby-lang.org/bugreport.html
    
    Abort trap: 6
