# typed: strong
# frozen_string_literal: true

# Add super admin
Ektar::User.create!(email: "super@ektar.com", password: "Pa$sw0r9", super_admin: true)
