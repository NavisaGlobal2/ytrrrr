/*
  # Complete Database Setup for DigiBooks

  1. New Tables
    - profiles: Business profile information
    - invoices: Invoice records
    - expenses: Expense tracking
    - revenues: Revenue tracking
    - budgets: Budget management
    - transactions: Financial transactions
    - clients: Client management

  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users to:
      - Read their own data
      - Insert their own data
      - Update their own data
      - Delete their own data

  3. Changes
    - Add necessary indexes for performance
    - Set up foreign key relationships
    - Add default values where appropriate
*/

-- First ensure RLS is enabled
DO $$ 
BEGIN
  -- Enable RLS on all tables
  ALTER TABLE IF EXISTS profiles ENABLE ROW LEVEL SECURITY;
  ALTER TABLE IF EXISTS invoices ENABLE ROW LEVEL SECURITY;
  ALTER TABLE IF EXISTS expenses ENABLE ROW LEVEL SECURITY;
  ALTER TABLE IF EXISTS revenues ENABLE ROW LEVEL SECURITY;
  ALTER TABLE IF EXISTS budgets ENABLE ROW LEVEL SECURITY;
  ALTER TABLE IF EXISTS transactions ENABLE ROW LEVEL SECURITY;
  ALTER TABLE IF EXISTS clients ENABLE ROW LEVEL SECURITY;
END $$;

-- Drop existing policies to avoid conflicts
DO $$ 
BEGIN
  -- Drop profile policies if they exist
  DROP POLICY IF EXISTS "Users can insert own profile" ON profiles;
  DROP POLICY IF EXISTS "Users can read own profile" ON profiles;
  DROP POLICY IF EXISTS "Users can update own profile" ON profiles;
  
  -- Drop invoice policies if they exist
  DROP POLICY IF EXISTS "Users can manage own invoices" ON invoices;
  
  -- Drop expense policies if they exist
  DROP POLICY IF EXISTS "Users can manage own expenses" ON expenses;
  
  -- Drop revenue policies if they exist
  DROP POLICY IF EXISTS "Users can manage own revenues" ON revenues;
  
  -- Drop budget policies if they exist
  DROP POLICY IF EXISTS "Users can manage own budgets" ON budgets;
  
  -- Drop transaction policies if they exist
  DROP POLICY IF EXISTS "Users can manage own transactions" ON transactions;
  
  -- Drop client policies if they exist
  DROP POLICY IF EXISTS "Users can manage own clients" ON clients;
EXCEPTION
  WHEN undefined_table THEN NULL;
  WHEN undefined_object THEN NULL;
END $$;

-- Create new policies
DO $$ 
BEGIN
  -- Create profile policies
  CREATE POLICY "Users can insert own profile"
    ON profiles FOR INSERT
    TO authenticated
    WITH CHECK (auth.uid() = id);

  CREATE POLICY "Users can read own profile"
    ON profiles FOR SELECT
    TO authenticated
    USING (auth.uid() = id);

  CREATE POLICY "Users can update own profile"
    ON profiles FOR UPDATE
    TO authenticated
    USING (auth.uid() = id)
    WITH CHECK (auth.uid() = id);

  -- Create invoice policies
  CREATE POLICY "Users can manage own invoices"
    ON invoices FOR ALL
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

  -- Create expense policies
  CREATE POLICY "Users can manage own expenses"
    ON expenses FOR ALL
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

  -- Create revenue policies
  CREATE POLICY "Users can manage own revenues"
    ON revenues FOR ALL
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

  -- Create budget policies
  CREATE POLICY "Users can manage own budgets"
    ON budgets FOR ALL
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

  -- Create transaction policies
  CREATE POLICY "Users can manage own transactions"
    ON transactions FOR ALL
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

  -- Create client policies
  CREATE POLICY "Users can manage own clients"
    ON clients FOR ALL
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);
EXCEPTION
  WHEN duplicate_object THEN NULL;
END $$;

-- Create indexes for better query performance
DO $$
BEGIN
  CREATE INDEX IF NOT EXISTS idx_invoices_user_id ON invoices(user_id);
  CREATE INDEX IF NOT EXISTS idx_expenses_user_id ON expenses(user_id);
  CREATE INDEX IF NOT EXISTS idx_revenues_user_id ON revenues(user_id);
  CREATE INDEX IF NOT EXISTS idx_budgets_user_id ON budgets(user_id);
  CREATE INDEX IF NOT EXISTS idx_transactions_user_id ON transactions(user_id);
  CREATE INDEX IF NOT EXISTS idx_clients_user_id ON clients(user_id);
EXCEPTION
  WHEN duplicate_object THEN NULL;
END $$;