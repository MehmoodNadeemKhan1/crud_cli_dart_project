import 'implementation_interface.dart';
import 'user_details_model.dart';
import 'dart:io';

class UserDetailsFileRepository implements IRepository<UserData>
{
    @override
    Future<void> create(UserData item) async
    {
        final basePath = "${Directory.current.path}${Platform.pathSeparator}fileStorage";
        final directory = Directory(basePath);

        if (!(await directory.exists())) 
        {
            await directory.create(recursive: true);
            print("Created directory: $basePath");
        }

        final filePath = "$basePath${Platform.pathSeparator}fileStorage.txt";
        final file = File(filePath);

        if (!(await file.exists())) 
        {
            await file.create(recursive: true);
            print("Created file: $filePath");

            final header = '''
|-------------------------------------------------------------------------------------------------------------------------|
| ${'ID'.padRight(10)} | ${'First Name'.padRight(15)} | ${'Last Name'.padRight(15)} | ${'Age'.padRight(5)} | ${'Birth Year'.padRight(12)} | ${'Nationality'.padRight(15)}                |
|-------------------------------------------------------------------------------------------------------------------------|
''';
            await file.writeAsString(header, mode: FileMode.append);
        }
        else 
        {
            print("File already exists at: $filePath");
        }


        final row =
            "| ${(item.userId?.toString() ?? '').padRight(10)} "
            "| ${(item.firstName ?? '').padRight(15)} "
            "| ${(item.lastName ?? '').padRight(15)} "
            "| ${(item.age?.toString() ?? '').padRight(5)} "
            "| ${(item.birthYear ?? '').padRight(12)} "
            "| ${(item.nationality ?? '').padRight(15)} |\n";

        final lines = await file.readAsLines();
        final dataLines = lines.skip(3).where((line) => line.trim().isNotEmpty);
        for (final line in dataLines)
        {
            final cols = line.split("|").map((c) => c.trim()).toList();

            if (cols[1] == item.userId)
            {
                print("The UserId: ${item.userId} Already exists in the file ");
                return;
            }
        }
        await file.writeAsString(row, mode: FileMode.append);
        print("Data Sucessfully created");
    }

    @override
    Future<void> delete(String id) async
    {
        final basePath = "${Directory.current.path}${Platform.pathSeparator}fileStorage";
        final filePath = "$basePath${Platform.pathSeparator}fileStorage.txt";
        final file = File(filePath);

        if (!(await file.exists())) 
        {
            print("File does not exist: $filePath");
            return;
        }

        final lines = await file.readAsLines();

        if (lines.length <= 3) 
        {
            print("No data rows found.");
            return;
        }

        final header = lines.take(3).toList();
        final dataLines = lines.skip(3).where((line) => line.trim().isNotEmpty).toList();

        final updatedData = dataLines.where((line)
            {
                final cols = line.split("|").map((c) => c.trim()).toList();
                return cols[1] != id;  // keep only users whose ID does not match
            }
        ).toList();

        if (updatedData.length == dataLines.length) 
        {
            print("User with ID=$id not found.");
            return;
        }

        final newContent = [...header, ...updatedData].join("\n");
        await file.writeAsString(newContent);

        print("User with ID=$id deleted successfully.");
    }

    @override
    Future<void> deleteAll() async
    {
        final basePath = "${Directory.current.path}${Platform.pathSeparator}fileStorage";
        final filePath = "$basePath${Platform.pathSeparator}fileStorage.txt";
        final file = File(filePath);
        if (!(await file.exists())) 
        {
            print("File does not exist: $filePath");
        }
        final lines = await file.readAsLines();
        final headerLines = lines.take(3).toList();
        await file.writeAsString('${headerLines.join('\n')}\n');
        print("All data rows deleted successfully");
    }

    @override
    Future<UserData?> findById(String id) async
    {
        final basePath = "${Directory.current.path}${Platform.pathSeparator}fileStorage";
        final filePath = "$basePath${Platform.pathSeparator}fileStorage.txt";
        final file = File(filePath);

        if (!(await file.exists())) 
        {
            print("File does not exist: $filePath");
            return null;
        }
        final lines = await file.readAsLines();
        if (lines.length <= 3) 
        {
            print("No data rows found.");
            return null;
        }
        final dataLines = lines.skip(3).where((line) => line.trim().isNotEmpty);

        for (final line in dataLines)
        {
            final cols = line.split("|").map((c) => c.trim()).toList();

            if (cols[1] == id) 
            {
                return UserData(
                    userId: cols[1],
                    firstName: cols[2],
                    lastName: cols[3],
                    age: int.tryParse(cols[4]) ?? 0,
                    birthYear: cols[5],
                    nationality: cols[6]
                );
            }
        }

        print("User with ID=$id not found.");
        return null;
    }

    @override
    Future<List<UserData>>? list() async
    {
        final basePath = "${Directory.current.path}${Platform.pathSeparator}fileStorage";
        final filePath = "$basePath${Platform.pathSeparator}fileStorage.txt";
        final file = File(filePath);

        if (!(await file.exists())) 
        {
            print("File does not exist: $filePath");
            return [];
        }
        final lines = await file.readAsLines();
        if (lines.length <= 3) 
        {
            return [];
        }

        final dataLines = lines.skip(3).where((line) => line.trim().isNotEmpty);
        final users = dataLines.map((line)
            {
                final cols = line.split("|").map((c) => c.trim()).toList();

                return
                UserData(
                    userId: cols[1],
                    firstName: cols[2],
                    lastName: cols[3],
                    age: int.tryParse(cols[4]) ?? 0,
                    birthYear: cols[5],
                    nationality: cols[6]
                );
            }
        ).toList();

        return users;
    }

    @override
    Future<void> update(String id, UserData updatedItem) async
    {
        final basePath = "${Directory.current.path}${Platform.pathSeparator}fileStorage";
        final filePath = "$basePath${Platform.pathSeparator}fileStorage.txt";
        final file = File(filePath);

        if (!(await file.exists())) 
        {
            print("File does not exist: $filePath");
            return;
        }

        final lines = await file.readAsLines();

        if (lines.length <= 3) 
        {
            print("No data found in database.");
            return;
        }

        final header = lines.take(3).toList();
        final dataLines = lines.skip(3).toList();

        bool updated = false;

        final newDataLines = dataLines.map((line)
            {
                if (line.trim().isEmpty) return line;

                final cols = line.split("|").map((c) => c.trim()).toList();
                if (cols.isNotEmpty && cols[1] == id) 
                {
                    updated = true;
                    return "| ${id.padRight(10)} | ${updatedItem.firstName?.padRight(15)} | ${updatedItem.lastName?.padRight(15)} | ${updatedItem.age.toString()?.padRight(5)} | ${updatedItem.birthYear?.padRight(12)} | ${updatedItem.nationality?.padRight(15)} |";
                }
                return line;
            }
        ).toList();

        if (!updated) 
        {
            print("User with id $id not found.");
            return;
        }

        // Write file back
        final newFileContent = [...header, ...newDataLines].join("\n");
        await file.writeAsString(newFileContent);

        print("User with id $id updated successfully.");
    }

}

