require 'faker'

require_relative 'module.data_loader'
include DataLoader

module Faker
  class CPG < Base
    class << self

      # --------------------------------------------------
      # Constants
      # --------------------------------------------------

      MIN_AGE = 18
      MAX_AGE = 75

      EMPLOYMENT_STATUSES = %w[ Clergy Lay ]

      PREFIXES = {
        EMPLOYMENT_STATUSES[0] => {
          M: DataLoader.get_data_lines('male_clergy_designations'),
          F: DataLoader.get_data_lines('female_clergy_designations')
        },
        EMPLOYMENT_STATUSES[1] => {
          M: %w[ Mr. Dr. ],
          F: %w[ Mrs. Ms. Miss Dr. ]
        }
      }

      FIRST_NAMES = {
        M: DataLoader.get_data('male_first_names'),
        F: DataLoader.get_data('female_first_names')
      }

      POSITION_TITLES = {
        EMPLOYMENT_STATUSES[0] => DataLoader.get_data_lines('clergy_position_titles'),
        EMPLOYMENT_STATUSES[1] => DataLoader.get_data_lines('lay_position_titles')
      }

      MIN_PASSWORD_LENGTH = 8
      MAX_PASSWORD_LENGTH = 16
      SPECIAL_CHARACTERS = %w[ ! @ # $ % ^ & * ]


      # --------------------------------------------------
      # Generators
      # --------------------------------------------------

      def ssn_or_tax_id
        numerify('###-##-####')
      end

      def gender
        %w[ M F ].sample
      end

      def employment_status
        EMPLOYMENT_STATUSES.sample
      end

      def date delta=0
        Time.new(
          Time.now.year + delta, # year
          rand(1..12), # month
          rand(1..28) # day
        ).strftime "%m/%d/%y"
      end

      def date_of_birth
        date(-(MIN_AGE + rand(MAX_AGE - MIN_AGE)))
      end

      def hire_date
        date(-(rand(25)+1))
      end

      def prefix status, gender
        PREFIXES[status][gender.to_sym].sample
      end

      def first_name gender
        FIRST_NAMES[gender.to_sym].sample
      end

      def password
        # generate letters
        output = Faker::Internet.password MIN_PASSWORD_LENGTH
        # insert number
        output.insert(rand(MIN_PASSWORD_LENGTH)+1, Faker::Number.number(3))
        # insert special character
        output.insert(rand(MIN_PASSWORD_LENGTH)+1, SPECIAL_CHARACTERS.sample)
        # trim
        output[0, MAX_PASSWORD_LENGTH]
      end

      def position_title status
        POSITION_TITLES[status].sample
      end

      def exempt_status
        %w[ Exempt Non-Exempt ].sample
      end

      def health_coverage_source
        %w[ InstitutionProvidedPlan SpousePartnerPlan MilitaryPlan Medicare Other None ].sample
      end

      def health_coverage_level source
        source != 'None' ? %w[ EmployeePlusSpouse EmployeePlusChildren Family ].sample : nil
      end

    end
  end

end
