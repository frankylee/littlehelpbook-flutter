# Little Help Book

![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white) ![iOS](https://img.shields.io/badge/iOS-3DDC84?style=for-the-badge&logo=apple&logoColor=white) 

![Flutter](https://img.shields.io/badge/flutter-3.13.1-blue) ![Dart](https://img.shields.io/badge/dart-3.1.0-blue)

Little Help Book is a collection of providers and services in Lane County, Oregon, organized and maintained by [White Bird](https://whitebirdclinic.org). The following are White Bird's core principles:

> Mission: White Bird is a collective environment organized to enable people to gain control of their social, emotional, and physical well-being through direct service, education, and community.

> Vision: White Bird Clinic provides compassionate, humanistic healthcare, and supportive services to individuals in our community, so everyone receives the care they need.

> Values: White Bird Clinic’s core values are compassion, client-centered care, community focus, individual empowerment, and service accessibility.

**_Disclaimer: This is an open-source project that aims to deliver a cross-platform mobile app experience for Little Help Book. This is not an official project of White Bird._**

---

## Architecture

We use [PowerSync](https://docs.powersync.co/integration-guides/supabase-+-powersync) to provide an offline-first experience for our [Supabase](https://supabase.com/docs/guides/getting-started/architecture) backend. This allows us to support users with a poor internet connection and make Little Help Book accessible to everyone.

<img src="https://293222281-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FV9geAO9ITPi8WOYK5o0r%2Fuploads%2FqTCR4omRLfS7NRtwcaea%2Fdocs-supabase-integration-diagram-narrow.png?alt=media&token=733ae899-6c64-4f7d-9af8-1c27230e2217" alt="PowerSync + Supabase project architecture" />

###### Credit: Image from PowerSync documentation.

[Read more about Supabase + PowerSync architecture.](https://docs.powersync.co/integration-guides/supabase-+-powersync#architecture)
