import 'package:powersync/powersync.dart';

/// The sync system itself is schemaless — the client syncs any data as received, in JSON format, regardless of the data
/// model on the client. The schema as supplied on the client is only a view on top of the schemaless data.
/// https://docs.powersync.co/usage/installation/client-side-setup/define-schema
const schema = Schema(
  [
    Table(
      'categories',
      [
        Column.text('name_en'),
        Column.text('name_es'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('deleted_at'),
      ],
    ),
    Table(
      'services',
      [
        Column.text('name_en'),
        Column.text('name_es'),
        Column.text('category_id'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('deleted_at'),
      ],
      indexes: [
        Index('categories', [IndexedColumn('category_id')]),
      ],
    ),
    Table(
      'providers',
      [
        Column.text('name'),
        Column.text('description_en'),
        Column.text('description_es'),
        Column.text('email'),
        Column.text('phone'),
        Column.text('website'),
        Column.text('services'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('deleted_at'),
      ],
    ),
    Table(
      'locations',
      [
        Column.text('provider_id'),
        Column.text('name'),
        Column.text('email'),
        Column.text('phones'),
        Column.integer('is_multilingual'),
        Column.integer('is_wheelchair_access'),
        Column.text('address_line_1'),
        Column.text('address_line_2'),
        Column.text('city'),
        Column.text('state'),
        Column.text('zip_code'),
        Column.real('latitude'),
        Column.real('longitude'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('deleted_at'),
      ],
      indexes: [
        Index('providers', [IndexedColumn('provider_id')]),
      ],
    ),
    Table(
      'schedules',
      [
        Column.text('location_id'),
        Column.text('week_days'),
        Column.integer('numeric_day'),
        Column.text('opens_at'),
        Column.text('closes_at'),
        Column.text('valid_from'),
        Column.text('valid_to'),
        Column.text('created_at'),
        Column.text('updated_at'),
        Column.text('deleted_at'),
      ],
      indexes: [
        Index('locations', [IndexedColumn('location_id')]),
      ],
    ),
  ],
);
