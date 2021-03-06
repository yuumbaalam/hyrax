# Pull in tasks from AF::Noid
af_noid_path = Gem.loaded_specs['active_fedora-noid'].full_gem_path
load "#{af_noid_path}/lib/tasks/noid_tasks.rake"

namespace :hyrax do
  namespace :noid do
    desc 'Migrate minter state file'
    task migrate_statefile: :environment do
      ENV['AFNOID_STATEFILE'] = Hyrax.config.minter_statefile
      Rake::Task['active_fedora:noid:migrate_statefile'].invoke if needs_migration?(Hyrax.config.minter_statefile)
    end
  end
end

def needs_migration?(statefile)
  !!YAML.load(File.open(statefile).read)
rescue Psych::SyntaxError, Errno::ENOENT
  false
end
