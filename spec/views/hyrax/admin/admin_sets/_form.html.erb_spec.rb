require 'spec_helper'

RSpec.describe 'hyrax/admin/admin_sets/_form.html.erb', type: :view do
  let(:admin_set) { create(:admin_set) }
  let!(:workflow) { Sipity::Workflow.create!(name: "default", label: "default") }
  let!(:permission_template) { Hyrax::PermissionTemplate.find_or_create_by(admin_set_id: admin_set.id, workflow_name: 'default') }
  before do
    @form = Hyrax::Forms::AdminSetForm.new(admin_set, permission_template)
    render
  end
  it "has 4 tabs" do
    expect(rendered).to have_selector('#description')
    expect(rendered).to have_selector('#participants')
    expect(rendered).to have_selector('#visibility')
    expect(rendered).to have_selector('#workflow')
  end
end
