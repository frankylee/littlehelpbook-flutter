# Little Help Book

![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white) ![iOS](https://img.shields.io/badge/iOS-3DDC84?style=for-the-badge&logo=apple&logoColor=white) 

![Flutter](https://img.shields.io/badge/flutter-3.16.8-blue) ![Dart](https://img.shields.io/badge/dart-3.2.5-blue)

Little Help Book is a collection of providers and services in Lane County, Oregon, organized and maintained by [White Bird](https://whitebirdclinic.org). The following are White Bird's core principles:

> Mission: White Bird is a collective environment organized to enable people to gain control of their social, emotional, and physical well-being through direct service, education, and community.
>
> Vision: White Bird Clinic provides compassionate, humanistic healthcare, and supportive services to individuals in our community, so everyone receives the care they need.
>
> Values: White Bird Clinic’s core values are compassion, client-centered care, community focus, individual empowerment, and service accessibility.

**_Disclaimer: This is an open-source project that aims to deliver a cross-platform mobile app experience for Little Help Book. This is not an official project of White Bird._**

---

## Architecture

We use [PowerSync](https://docs.powersync.co/integration-guides/supabase-+-powersync) to provide an offline-first experience for our [Supabase](https://supabase.com/docs/guides/getting-started/architecture) backend. This allows us to support users with a poor internet connection and make Little Help Book accessible to everyone.

<img src="https://293222281-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FV9geAO9ITPi8WOYK5o0r%2Fuploads%2FqTCR4omRLfS7NRtwcaea%2Fdocs-supabase-integration-diagram-narrow.png?alt=media&token=733ae899-6c64-4f7d-9af8-1c27230e2217" alt="PowerSync + Supabase project architecture" />

###### Credit: Image from PowerSync documentation.

[Read more about Supabase + PowerSync architecture.](https://docs.powersync.co/integration-guides/supabase-+-powersync#architecture)

## Project Flavors and Env Vars

### Project Flavors

This project utilizes flavors, Flutter and native (iOS/Android) platforms. This approach allows us to use multiple configurations while ensuring we have a dedicated app for each flavor. In addition, it gives us confidence that we are testing in the right environment while being able to have both a Debug & Release build for each flavor. This is needed since a Debug build cannot be an accurate representation of the App's Animations/Live experience. A release build is required to test the full experience.

There are also a launching limitation on iOS with Debug builds where you MUST have an active debug session to launch the app. Without this, you will not be able to launch the app once the debug session closes. To test repeat app launches you will need to use a Release build. This is why flavors are important, since a debug build can't just point to Dev while release points to production. It's too limiting.

Our Flavors are:

-   Dev
-   Stage
-   Production

To use these flavors, run the setup script as:

-   Dev `./scripts/setup` or `./scripts/setup dev`
-   Stage `./scripts/setup stage`
-   Production `./scripts/setup production`

This will fetch the flavor and env vars from 1Password and save them as `.env` file. The setup script also runs `build-runner.sh` which generates the `.env` file into `app_config.dart`.

To use these flavors via Flutter Terminal you will want to use the CLI Arg `--flavor dev` or `--flavor stage` or `--flavor production`.

We have our own env `FLAVOR` variable, so we can understand the flavor in the App's Codebase.

### Env Vars

This project uses a `.env` file to structure the app's environment variable needs. As mentioned above the setup will interface with Doppler to pull the appropriate env vars. This script will also run `build-runner` which takes the `.env`file and assigns them to various `AppConfig` variables. These values are obfuscated such that they cannot be read as plain text. For more information see the [envied][] docs.

## Doppler

[Dopper](https://www.doppler.com) represents "The New Era of Secrets Management" by handling all aspects of what goes into managing secrets.

Doppler is used to control the secrets for the app which uses Doppler's powerful templating tool. The `.env_doppler` file represents the template used for each flavor specific `.env` files. Using the following command will populate the `.env`, but this command does not need to be ran manually, it will be ran in the `./scripts/setup <flavor>` script.

Ex:
This will populate the `.env` with the values for production.
```doppler secrets substitute .env_doppler --output .env --config production```

### iOS CocoaPods
iOS uses CocoaPods to manage the dependencies. An antiquted package manager but here we are. When new packages are added, sometimes it is nessecary to nuke the `ios/Pods` folder and the `Podfile.lock`. Then run `cd ios && pod install --repo-update && cd ../` to get the new pods. Then the setup script will succeed.

## Feature-Sliced Design

This project follows Feature-Sliced Design, an architectural methodology for frontend projects.

<img src="https://feature-sliced.design/assets/ideal-img/visual_schema.b6c18f6.1030.jpg" alt="Feature-Sliced Design visual schema of layers, slices, and segments" />

###### Credit: Image from Feature-Sliced Design documentation.

[Read more about Feature-Sliced Design.](https://feature-sliced.design)
