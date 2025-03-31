# This file creates sample data for the Envision application
# Run with: rails db:seed
# Reset and run with: rails db:seed:replant

puts "\n== Seeding Database with Sample Data ==\n\n"

# Clear existing data to avoid duplicates
if Rails.env.development?
  puts "Cleaning database..."
  TeamMembership.destroy_all
  Team.destroy_all
  User.destroy_all
  puts "Database cleaned.\n\n"
end

# Create admin user
admin = User.create!(
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  name: "Admin User",
  username: "admin"
)
puts "Created admin user: #{admin.email} (password: password)"

# Create regular users
users = [
  { name: "John Smith", username: "johnsmith", email: "john@example.com" },
  { name: "Jane Doe", username: "janedoe", email: "jane@example.com" },
  { name: "Bob Johnson", username: "bobjohnson", email: "bob@example.com" },
  { name: "Alice Williams", username: "alicew", email: "alice@example.com" },
  { name: "Charlie Brown", username: "charlieb", email: "charlie@example.com" },
  { name: "Diana Prince", username: "dianap", email: "diana@example.com" },
  { name: "Ethan Hunt", username: "ethanh", email: "ethan@example.com" },
  { name: "Fiona Gallagher", username: "fionag", email: "fiona@example.com" }
]

created_users = [admin] # Start with admin

users.each do |user_attrs|
  user = User.create!(
    email: user_attrs[:email],
    password: "password",
    password_confirmation: "password",
    name: user_attrs[:name],
    username: user_attrs[:username]
  )
  created_users << user
  puts "Created user: #{user.email} (password: password)"
end

puts "\nCreated #{created_users.size} users.\n\n"

# Create teams
teams_data = [
  { name: "Engineering", description: "Core engineering team responsible for backend development" },
  { name: "Frontend", description: "UI/UX and frontend development team" },
  { name: "DevOps", description: "Infrastructure and operations team" },
  { name: "Product", description: "Product management and design team" },
  { name: "QA", description: "Quality assurance and testing team" }
]

created_teams = []

teams_data.each do |team_attrs|
  team = Team.create!(
    name: team_attrs[:name],
    description: team_attrs[:description]
  )
  created_teams << team
  puts "Created team: #{team.name}"
end

puts "\nCreated #{created_teams.size} teams.\n\n"

# Create team memberships with different roles
puts "Creating team memberships..."

# Admin is a member of all teams with admin role
created_teams.each do |team|
  TeamMembership.create!(
    user: admin,
    team: team,
    role: "admin"
  )
  puts "Added #{admin.name} to #{team.name} as admin"
end

# Assign other users to teams with different roles
roles = ["admin", "member", "viewer"]

# Engineering team (all members)
created_users[1..3].each_with_index do |user, index|
  role = roles[index % roles.size]
  TeamMembership.create!(
    user: user,
    team: created_teams[0],
    role: role
  )
  puts "Added #{user.name} to #{created_teams[0].name} as #{role}"
end

# Frontend team
created_users[2..5].each_with_index do |user, index|
  role = roles[index % roles.size]
  TeamMembership.create!(
    user: user,
    team: created_teams[1],
    role: role
  )
  puts "Added #{user.name} to #{created_teams[1].name} as #{role}"
end

# DevOps team
created_users[3..6].each_with_index do |user, index|
  role = roles[index % roles.size]
  TeamMembership.create!(
    user: user,
    team: created_teams[2],
    role: role
  )
  puts "Added #{user.name} to #{created_teams[2].name} as #{role}"
end

# Product team
created_users[4..7].each_with_index do |user, index|
  role = roles[index % roles.size]
  TeamMembership.create!(
    user: user,
    team: created_teams[3],
    role: role
  )
  puts "Added #{user.name} to #{created_teams[3].name} as #{role}"
end

# QA team
created_users[1..4].each_with_index do |user, index|
  role = roles[(index + 1) % roles.size] # Mix up the roles a bit
  TeamMembership.create!(
    user: user,
    team: created_teams[4],
    role: role
  )
  puts "Added #{user.name} to #{created_teams[4].name} as #{role}"
end

# Create portfolios, applications, and projects if those models exist
if defined?(Portfolio) && defined?(Application) && defined?(Project)
  puts "\n\nCreating hierarchical data model entities..."
  
  # Create portfolios
  portfolios = [
    { name: "Internal Tools", description: "Internal development tools and utilities" },
    { name: "Client Projects", description: "Client-facing applications and services" },
    { name: "Research", description: "Experimental and research projects" }
  ]
  
  created_portfolios = []
  
  portfolios.each do |portfolio_attrs|
    portfolio = Portfolio.create!(
      name: portfolio_attrs[:name],
      description: portfolio_attrs[:description]
    )
    created_portfolios << portfolio
    puts "Created portfolio: #{portfolio.name}"
  end
  
  # Create applications for each portfolio
  applications_data = [
    # Internal Tools portfolio
    { name: "Developer Dashboard", description: "Dashboard for developer metrics", portfolio: created_portfolios[0] },
    { name: "Code Review Tool", description: "Internal code review application", portfolio: created_portfolios[0] },
    
    # Client Projects portfolio
    { name: "E-commerce Platform", description: "Online shopping platform", portfolio: created_portfolios[1] },
    { name: "CRM System", description: "Customer relationship management", portfolio: created_portfolios[1] },
    
    # Research portfolio
    { name: "ML Experiments", description: "Machine learning experimental projects", portfolio: created_portfolios[2] },
    { name: "Blockchain Prototype", description: "Prototype blockchain implementation", portfolio: created_portfolios[2] }
  ]
  
  created_applications = []
  
  applications_data.each do |app_attrs|
    application = Application.create!(
      name: app_attrs[:name],
      description: app_attrs[:description],
      portfolio: app_attrs[:portfolio]
    )
    created_applications << application
    puts "Created application: #{application.name} in portfolio: #{application.portfolio.name}"
  end
  
  # Create projects for each application
  projects_data = [
    # Developer Dashboard projects
    { name: "Frontend", description: "Dashboard UI", path: "dashboard/frontend", application: created_applications[0] },
    { name: "Backend API", description: "Dashboard API", path: "dashboard/api", application: created_applications[0] },
    
    # Code Review Tool projects
    { name: "Core Engine", description: "Core review functionality", path: "code-review/engine", application: created_applications[1] },
    { name: "Web Interface", description: "Web UI for code review", path: "code-review/web", application: created_applications[1] },
    
    # E-commerce projects
    { name: "Product Catalog", description: "Product management", path: "ecommerce/catalog", application: created_applications[2] },
    { name: "Checkout System", description: "Payment processing", path: "ecommerce/checkout", application: created_applications[2] },
    
    # CRM projects
    { name: "Contact Management", description: "Customer contacts", path: "crm/contacts", application: created_applications[3] },
    { name: "Sales Pipeline", description: "Sales tracking", path: "crm/sales", application: created_applications[3] },
    
    # ML Experiments projects
    { name: "Text Classification", description: "NLP classification", path: "ml/text-classification", application: created_applications[4] },
    { name: "Image Recognition", description: "Computer vision", path: "ml/image-recognition", application: created_applications[4] },
    
    # Blockchain projects
    { name: "Smart Contracts", description: "Contract implementation", path: "blockchain/contracts", application: created_applications[5] },
    { name: "Distributed Ledger", description: "Ledger implementation", path: "blockchain/ledger", application: created_applications[5] }
  ]
  
  projects_data.each do |project_attrs|
    project = Project.create!(
      name: project_attrs[:name],
      description: project_attrs[:description],
      path: project_attrs[:path],
      application: project_attrs[:application]
    )
    puts "Created project: #{project.name} in application: #{project.application.name}"
  end
end

puts "\n== Seeding completed successfully! ==\n"
puts "\nSample login credentials:"
puts "Admin: admin@example.com / password"
puts "Regular user: john@example.com / password\n\n"
