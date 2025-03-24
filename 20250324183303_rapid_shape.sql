/*
  # Add business profile fields

  1. New Fields
    - Add RC number field
    - Add business type field
    - Add registration date field
    - Add VAT number field
    - Add contact fields (phone, website)
    - Add address field

  2. Security
    - Maintain existing RLS policies
*/

-- Add new columns to profiles table if they don't exist
DO $$ 
BEGIN
  -- RC Number
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'profiles' AND column_name = 'rc_number') THEN
    ALTER TABLE profiles ADD COLUMN rc_number text;
  END IF;

  -- Business Type
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'profiles' AND column_name = 'business_type') THEN
    ALTER TABLE profiles ADD COLUMN business_type text;
  END IF;

  -- Registration Date
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'profiles' AND column_name = 'registration_date') THEN
    ALTER TABLE profiles ADD COLUMN registration_date date;
  END IF;

  -- VAT Number
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'profiles' AND column_name = 'vat_number') THEN
    ALTER TABLE profiles ADD COLUMN vat_number text;
  END IF;

  -- Phone
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'profiles' AND column_name = 'phone') THEN
    ALTER TABLE profiles ADD COLUMN phone text;
  END IF;

  -- Website
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'profiles' AND column_name = 'website') THEN
    ALTER TABLE profiles ADD COLUMN website text;
  END IF;

  -- Address
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'profiles' AND column_name = 'address') THEN
    ALTER TABLE profiles ADD COLUMN address text;
  END IF;

END $$;

-- Existing RLS policies will automatically apply to new columns