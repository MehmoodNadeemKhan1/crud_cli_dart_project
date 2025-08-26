import 'server_based_implementation.dart';
import 'file_based_implementation.dart';
import 'database_based_implementation.dart';
import 'user_details_model.dart';
import 'package:args/args.dart';
import 'user_detail_app_database.dart';

void main(List<String> arguments) async
{

    final parser = ArgParser()
    ..addFlag(
        'server',
        abbr: 's',
        negatable: false,
        help: 'Enable server option.'
    )
    ..addFlag(
        'database',
        abbr: 'r',
        negatable: false,
        help: 'Enable file option.'
    )
        ..addFlag(
            'file',
            abbr: 'f',
            negatable: false,
            help: 'Enable file option.'
        )
    ..addOption(
        'create',
        abbr: 'c',
        help: 'Option is not specified.'
    )
    ..addFlag(
        'list',
        abbr: 'l',
        negatable: false,
        help: 'Option is not specified.'
    )
    ..addOption(
        'getone',
        abbr: 'g',
        help: 'Option is not specified.'
    )
    ..addOption(
        'delete',
        abbr: 'd',
        help: 'Option is not specified.'
    )
    ..addFlag(
        'delete-all',
        abbr: 'D',
        negatable: false,
        help: 'Option is not specified.'
    )
    ..addOption(
        'update',
        abbr: 'u',
        help: 'Option is not specified.'
    );
    final results = parser.parse(arguments);

    if (results['server'] == true)
    {
        if (results['create'] != null)
        {

            final createData = results['create'];
            if (createData != null)
            {
                final split = createData.split(",");
                final id = split.length > 0 ? split[0] : null;
                final firstName = split.length > 1 ? split[1] : null;
                final lastName = split.length > 2 ? split[2] : null;
                final age = split.length > 3 ? split[3] : null;
                final birthYear = split.length > 4 ? split[4] : null;
                final nationality = split.length > 5 ? split[5] : null;
                if (id == null && firstName == null && lastName == null && age == null && birthYear == null && nationality == null)
                {
                    print("All fields are required");
                }

                print('UserId: $id,FirstName: $firstName LastName: $lastName Age: $age BirthYear: $birthYear Nationality: $nationality');
                final api = UserDetailsApiRepository(ApiClient());
                await api.create(UserDetails(name: 'UserDetailsAPI', data: UserData(userId: id, firstName: firstName, lastName: lastName, age: int.parse(age), birthYear: birthYear, nationality: nationality)));
            }
            else
            {
                print("No created data provided please enter all fields");
            }

        }
        else if (results['list'] == true)
        {
            final api2 = UserDetailsApiRepository(ApiClient());
            final users2 = await api2.list();
            print(users2);
        }
        else if (results['getone'] != null)
        {
            final api = UserDetailsApiRepository(ApiClient());
            await api.findById(results['getone']);
        }
        else if (results['delete'] != null)
        {
            final api = UserDetailsApiRepository(ApiClient());
            await api.delete(results['delete']);

        }
        else if (results['delete-all'] == true)
        {
            final api = UserDetailsApiRepository(ApiClient());
            await api.deleteAll();
        }
        else if (results['update'] != null)
        {
            final createData = results['update'];
            if (createData != null) 
            {
                final split = createData.split(",");
                final id = split.length > 0 ? split[0] : null;
                final firstName = split.length > 1 ? split[1] : null;
                final lastName = split.length > 2 ? split[2] : null;
                final age = split.length > 3 ? split[3] : null;
                final birthYear = split.length > 4 ? split[4] : null;
                final nationality = split.length > 5 ? split[5] : null;

                if (id == null && firstName == null && lastName == null &&
                    age == null && birthYear == null && nationality == null) 
                {
                    print("All fields are required");
                }

                print('UserId: $id,FirstName: $firstName LastName: $lastName Age: $age BirthYear: $birthYear Nationality: $nationality');
                final api = UserDetailsApiRepository(ApiClient());
                await api.update(id, UserDetails(name: 'UserDetailsAPI', data: UserData(firstName:firstName, lastName:lastName, age:int.parse(age), birthYear:birthYear, nationality:nationality)));
            }
        }

        else
        {
            print("You entered the wrong flag for server");
        }
    }
    else if (results['file'] == true)
    {
        if (results['create'] != null)
        {
            final createData = results['create'];
            if (createData != null)
            {
                final split = createData.split(",");
                final id = split.length > 0 ? split[0] : null;
                final firstName = split.length > 1 ? split[1] : null;
                final lastName = split.length > 2 ? split[2] : null;
                final age = split.length > 3 ? split[3] : null;
                final birthYear = split.length > 4 ? split[4] : null;
                final nationality = split.length > 5 ? split[5] : null;

                if (id == null && firstName == null && lastName == null && age == null && birthYear == null && nationality == null)
                {
                    print("All fields are required");
                }

                print('UserId: $id,FirstName: $firstName LastName: $lastName Age: $age BirthYear: $birthYear Nationality: $nationality');

                final file = UserDetailsFileRepository();
                await file.create(UserData(userId: id, firstName: firstName, lastName: lastName, age: int.parse(age), birthYear: birthYear, nationality: nationality));

            }
            else
            {
                print("No created data provided please enter all fields");
            }

        }
        else if (results['list'] == true)
        {
            final file = UserDetailsFileRepository();
            print(await file.list());
        }
        else if (results['getone'] != null)
        {
            final file = UserDetailsFileRepository();
            print(await file.findById(results['getone']));

        }
        else if (results['delete'] != null)
        {
            final file = UserDetailsFileRepository();
            await file.delete(results['delete']);
        }
        else if (results['delete-all'] == true)
        {
            final file = UserDetailsFileRepository();
            await file.deleteAll();
            return null;
        }
        else if (results['update'] != null)
        {
            final createData = results['update'];
            if (createData != null)
            {
                final split = createData.split(",");
                final id = split.length > 0 ? split[0] : null;
                final firstName = split.length > 1 ? split[1] : null;
                final lastName = split.length > 2 ? split[2] : null;
                final age = split.length > 3 ? split[3] : null;
                final birthYear = split.length > 4 ? split[4] : null;
                final nationality = split.length > 5 ? split[5] : null;

                if (id == null && firstName == null && lastName == null &&
                    age == null && birthYear == null && nationality == null)
                {
                    print("All fields are required");
                }

                print('UserId: $id,FirstName: $firstName LastName: $lastName Age: $age BirthYear: $birthYear Nationality: $nationality');

                final file = UserDetailsFileRepository();
                await file.update(id, UserData(firstName: firstName, lastName: lastName, age: int.parse(age), birthYear: birthYear, nationality: nationality));

            }
        }
        else
        {
            print("You entered the wrong flag for file");
        }
    }else if(results['database'] == true){
        if (results['create'] != null)
        {

            final createData = results['create'];
            if (createData != null)
            {
                final split = createData.split(",");
                final id = split.length > 0 ? split[0] : null;
                final firstName = split.length > 1 ? split[1] : null;
                final lastName = split.length > 2 ? split[2] : null;
                final age = split.length > 3 ? split[3] : null;
                final birthYear = split.length > 4 ? split[4] : null;
                final nationality = split.length > 5 ? split[5] : null;
                if (id == null && firstName == null && lastName == null && age == null && birthYear == null && nationality == null)
                {
                    print("All fields are required");
                }

                print('UserId: $id,FirstName: $firstName LastName: $lastName Age: $age BirthYear: $birthYear Nationality: $nationality');
                final db = AppDatabase();
                final database = UserDetailsDatabaseRepository(db);
                 await database.create(UserDetails(name: 'UserDetailsAPI', data: UserData(userId: id, firstName: firstName, lastName: lastName, age: int.parse(age), birthYear: birthYear, nationality: nationality)));

            }
            else
            {
                print("No created data provided please enter all fields");
            }

        }
        else if (results['list'] == true)
        {
            // final api2 = UserDetailsApiRepository(ApiClient());
            // final users2 = await api2.list();
            // print(users2);
        }
        else if (results['getone'] != null)
        {
            // final api = UserDetailsApiRepository(ApiClient());
            // await api.findById(results['getone']);
        }
        else if (results['delete'] != null)
        {
            // final api = UserDetailsApiRepository(ApiClient());
            // await api.delete(results['delete']);

        }
        else if (results['delete-all'] == true)
        {
            // final api = UserDetailsApiRepository(ApiClient());
            // await api.deleteAll();
        }
        else if (results['update'] != null)
        {
            final createData = results['update'];
            if (createData != null)
            {
                final split = createData.split(",");
                final id = split.length > 0 ? split[0] : null;
                final firstName = split.length > 1 ? split[1] : null;
                final lastName = split.length > 2 ? split[2] : null;
                final age = split.length > 3 ? split[3] : null;
                final birthYear = split.length > 4 ? split[4] : null;
                final nationality = split.length > 5 ? split[5] : null;

                if (id == null && firstName == null && lastName == null &&
                    age == null && birthYear == null && nationality == null)
                {
                    print("All fields are required");
                }

                print('UserId: $id,FirstName: $firstName LastName: $lastName Age: $age BirthYear: $birthYear Nationality: $nationality');
                // final api = UserDetailsApiRepository(ApiClient());
                // await api.update(id, UserDetails(name: 'UserDetailsAPI', data: UserData(firstName:firstName, lastName:lastName, age:int.parse(age), birthYear:birthYear, nationality:nationality)));
            }
        }

        else
        {
            print("You entered the wrong flag for database");
        }
    }
    else
    {
        print("Neither server nor file flag provided");
    }

}
