# Little Help Book Edge Functions

## Usage

[Deno](https://deno.com/) and [Supabase CLI](https://github.com/supabase/cli) are required.

```sh
brew install deno
brew install supabase/tap/supabase
# Login to the Supabase CLI. This requires creating a new 
# access token  in the Supabase project dashboard.
supabase login
```

## Run the functions locally

```sh
# To start the the Supbase containers, you must be logged into 
# the CLI and the Docker daemon must be running.
supabase start
supabase functions serve --env-file ./supabase/.env
```

## PowerSync Custom Authentication

To facilitate anonymous authentication to PowerSync, we must create custom JWTs. These Edge functions from the [PowerSync JWKS Example](https://github.com/journeyapps/powersync-jwks-example).

A key-pair (public and private key) is generated. The public key is served on a public [JWKS](https://auth0.com/docs/secure/tokens/json-web-tokens/json-web-key-sets) URI. The private key is then used to generate JWTs for authenticated Supabase users and/or anonymous users. The PowerSync instance then validates these JWTs against the public key from the JWKS URI.

### Generate a new key-pair

```sh
deno run supabase/functions/_powersync/generate-keys.ts
```

Run the first two `supabase secrets set` commands in the output to configure the keys on Supabase.

#### Rotating keys

Generate a new key and update the secrets on Supabase. PowerSync will automatically pick up the new key and verify the new tokens.

There may be some authentication failures while clients still use old JWTs. The clients should automatically retrieve new keys and retry. To completely prevent those errors, the `powersync-jwks` function could be adapted to serve both the old and the new public keys at the same time.

### Deploy the functions

```sh
supabase functions deploy --no-verify-jwt powersync-jwks
# Deploy one or both of these, depending on whether signed-in 
# and/or anonymous users should be allowed.
supabase functions deploy powersync-auth
supabase functions deploy powersync-auth-anonymous
```

### Invoke PowerSync auth functions

Update the client application to invoke the `powersync-auth` or `powersync-auth-anonymous` function to generate the JWT.

* Example usage of `powersync-auth`: https://github.com/journeyapps/powersync-supabase-flutter-demo/pull/3
* Example usage of `powersync-auth-anonymous`: https://github.com/journeyapps/powersync-supabase-flutter-demo/pull/4
* Note that it's possible to use a mix of both methods. This would be done with a token parameter query. In the context of the above examples, this would be done using `token_parameters.user_id != 'anonymous'`. In the future, PowerSync will ideally change this to use a separate parameter for authenticated / anonymous queries.
