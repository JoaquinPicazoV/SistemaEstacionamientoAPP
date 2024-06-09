import 'package:postgres/postgres.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  late Connection _connection;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<void> initialize() async {
    _connection = await Connection.open(
      Endpoint(
        host: 'ep-sparkling-dream-a5pwwhsb.us-east-2.aws.neon.tech',
        database: 'estacionamientosUlagos',
        username: 'estacionamientosUlagos_owner',
        password: 'D7HQdX0nweTx',
      ),
      settings: const ConnectionSettings(sslMode: SslMode.require),
    );
    print('has connection!');
  }

  Connection get connection => _connection;
}
