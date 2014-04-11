require 'faker'

module Faker
  class CPG < Base
    class << self

      # --------------------------------------------------
      # Constants
      # --------------------------------------------------

      MIN_AGE = 18
      MAX_AGE = 75

      PREFIXES = {
        M: %w[ Mr. Dr. ],
        F: %w[ Mrs. Ms. Miss Dr. ],
        C: [
          'The Reverend / Father',
          'The Reverend / Mother',
          'The Reverend / Pastor',
          'The Reverend / Chaplain',
          'The Reverend / Mr.',
          'The Reverend / Deacon',
          'The Reverend / Ms.',
          'The Reverend / Mrs.',
          'The Reverend / Miss',
          'The Reverend Dr.',
          'Brother',
          'Sister',
          'The Most Reverend',
          'The Most Reverend Dr.',
          'The Reverend Canon',
          'The Reverend Canon Dr.',
          'The Right Reverend',
          'The Right Reverend Dr.',
          'The Venerable',
          'The Venerable Dr.',
          'The Very Reverend',
          'The Very Reverend Dr.'
        ]
      }

      FIRST_NAMES = {
        M: File.read(File.dirname(__FILE__) + '/data/male_first_names.txt').split(/\s+/),
        F: File.read(File.dirname(__FILE__) + '/data/female_first_names.txt').split(/\s+/)
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

      def prefix gender, status
        key = status == 'Clergy' ? 'C' : gender
        PREFIXES[key.to_sym].sample
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

    end
  end

end
