require 'faker'
require_relative 'faker.cpg'
require_relative 'helpers'
require_relative 'extensions'

# avoid pescy deprecation warning...
I18n.enforce_available_locales = false


class Person

  # Constants
  # --------------------------------------------------

  # Defines schema used for magic accessors and order for to_s
  SCHEMA = %w[

    ssn_or_tax_id
    date_of_birth

    gender

    designation_salutation
    first_name
    middle_name
    last_name
    suffix

    username
    password

    employment_status

    position_title
    exempt_status
    hours_expected_per_year
    hire_date

    mailing_address_1
    mailing_address_2
    city
    state
    postal_code
    country
    phone
    personal_email
    work_email
    home_address_1
    home_address_2
    city
    state
    postal_code
    country

    health_coverage_source
    health_coverage_level
    premium_percentage
    contributes_to_pension

  ]


  # Initializer
  # --------------------------------------------------
  def initialize
    self.class.fields
    populate
  end


  # Populate
  # --------------------------------------------------
  def populate
    @ssn_or_tax_id = Faker::CPG.ssn_or_tax_id
    @date_of_birth = Faker::CPG.date_of_birth

    @gender = Faker::CPG.gender
    @employment_status = %w[ Lay Clergy ].sample

    # TODO: make lay/clergy specific
    @designation_salutation = Faker::CPG.prefix @gender
    @first_name = Faker::CPG.first_name @gender
    @middle_name = prob 5, Faker::CPG.first_name(@gender)
    @last_name = Faker::Name.last_name
    @suffix = prob 2, Faker::Name.suffix

    name_seed = "#{@first_name} #{@last_name} #{Faker::Number.number 3}"

    @position_title = Faker::Name.title
    @exempt_status = %w[ Exempt Non-Exempt ].sample
    @hours_expected_per_year = rand(1000) + 500
    @hire_date = Faker::CPG.hire_date

    @mailing_address_1 = Faker::Address.street_address
    @mailing_address_2 = prob 3, Faker::Address.secondary_address
    @mailing_city = Faker::Address.city
    @mailing_state = Faker::Address.state
    @mailing_postal_code = Faker::Address.zip_code
    @mailing_country = Faker::Address.country

    if probability 3
      @home_address_1 = Faker::Address.street_address
      @home_address_2 = prob 3, Faker::Address.secondary_address
      @home_city = Faker::Address.city
      @home_state = Faker::Address.state
      @home_postal_code = Faker::Address.zip_code
      @home_country = Faker::Address.country
    end

    @phone = Faker::PhoneNumber.phone_number
    @personal_email = Faker::Internet.safe_email(name_seed)
    @work_email = Faker::Internet.safe_email(name_seed)

    @health_coverage_source = %w[ ? MilitaryPlan ].sample
    @health_coverage_level = %w[ ? EmployeePlusSpouse ].sample
    @premium_percentage = rand(6)
    @contributes_to_pension = %w[ Yes No ].sample

    @username = Faker::Internet.user_name(name_seed)
    @password = Faker::CPG.password

  end


  # Magic accessors
  # --------------------------------------------------
  class << self
    def fields
      SCHEMA.each do |item|
        attr_accessor item
      end
    end
  end


  # Full Name
  # --------------------------------------------------
  def full_name
    [
      designation_salutation,
      first_name,
      middle_name,
      last_name,
      suffix
    ].compact.join ' '
  end


  # to String
  # --------------------------------------------------
  def to_s sep=" | "
    (@a || self.to_a).join sep
  end


  # to CSV
  # --------------------------------------------------
  def to_csv
    (@a || self.to_a).to_csv
  end


  # to Array
  # --------------------------------------------------
  def to_a
    output = []
    Person::SCHEMA.each do |item|
      output << self.send(item)
    end
    @a = output
  end

end
