-- Replace 'pollitify_hub' with your actual database username
GRANT CREATE, USAGE ON SCHEMA public TO pollitify_hub;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO pollitify_hub;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO pollitify_hub;

-- For future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO pollitify_hub;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO pollitify_hub;