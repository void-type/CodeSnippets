# CSharp Snippets

## Chapsas WhenAll approach

This throws the aggregate exception instead of blowing up on the first exception.

```csharp
public static async Task<IEnumerable<T>> WhenAll<T>(params Task<T>[] tasks)
{
    var allTasks = Task.WhenAll(tasks);
    try
    {
        return await allTasks;
    }
    catch (Exception)
    {
        //ignore
    }
    throw allTasks.Exception ?? throw new Exception("This can’t possibly happen");
}
```
