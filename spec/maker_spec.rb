require_relative 'spec_helper'

describe Maker do
	let(:enrique) { Maker.new(name: "Enrique Comba Riepenhausen", username: "ecomba", email: "ecomba@makersacademy.com", password: "s3cr3t", password_confirmation: "s3cr3t") }
	
	context "(upon creation)" do
		it "should have an email address" do
			expect(enrique.email).to eq("ecomba@makersacademy.com")
		end
		it "should have a name" do
			expect(enrique.name).to eq("Enrique Comba Riepenhausen")
		end
		it "should have a username" do
			expect(enrique.username).to eq("ecomba")
		end
		it "should have a password digest" do
			expect(enrique.password_digest.length).to be > 10
		end
	end
end

# | name          | Enrique Comba Riepenhausen |
# | username      | ecomba                     |
# | email         | ecomba@makersacademy.com   |
# | password      | s3cr3t                     |
# | confirmation  | s3cr3t   