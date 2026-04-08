---
globs: ["**/*Supabase*", "**/*Database*", "**/*Repository*"]
---
# Supabase Rules

- Use the shared `SupabaseService` singleton for all database operations.
- All queries go through the service layer, never directly from ViewModels.
- Use `Codable` models for type-safe queries — column names in `CodingKeys` as snake_case.
- Handle auth state changes reactively.
- Database column names are `snake_case`, Swift properties are `camelCase`.
- Schema constants live in `DatabaseSchema` enum — never use inline table/column name strings.
