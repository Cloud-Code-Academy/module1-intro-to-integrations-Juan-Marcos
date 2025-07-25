@IsTest
public class JSONPlaceholderExerciseTest {

    @IsTest
    static void testGetPostById() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(200, JSONPlaceholderMock.getSampleGetResponse()));

        // Act
        JSONPlaceholderExercise.PostResponse response = JSONPlaceholderExercise.getPostById(1);

        // Assert
        Assert.isNotNull(response, 'Response should not be null');
        Assert.areEqual(1, response.id, 'Post ID should match the request');
        Assert.areEqual('Sample Post', response.title, 'Post title should match the mock response');
    }

    @IsTest
    static void testCreatePost() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(201, JSONPlaceholderMock.getSamplePostResponse()));

        // Act
        JSONPlaceholderExercise.PostResponse response = JSONPlaceholderExercise.createPost('New Post', 'This is a new post', 1);

        // Assert
        Assert.isNotNull(response, 'Response should not be null');
        Assert.areEqual(101, response.id, 'New post should have ID 101');
        Assert.areEqual('New Post', response.title, 'Post title should match the request');
    }

    @IsTest
    static void testUpdatePost() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(200, JSONPlaceholderMock.getSamplePutResponse()));

        // Act
        JSONPlaceholderExercise.PostResponse response = JSONPlaceholderExercise.updatePost(1, 'Updated Post', 'This is an updated post', 1);

        // Assert
        Assert.isNotNull(response, 'Response should not be null');
        Assert.areEqual('Updated Post', response.title, 'Post title should be updated');
    }

    @IsTest
    static void testPatchPostTitle() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(200, JSONPlaceholderMock.getSamplePatchResponse()));

        // Act
        JSONPlaceholderExercise.PostResponse response = JSONPlaceholderExercise.patchPostTitle(1, 'Updated Title');

        // Assert
        Assert.isNotNull(response, 'Response should not be null');
        Assert.areEqual('Updated Title', response.title, 'Post title should be updated');
    }

    @IsTest
    static void testDeletePost() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new JSONPlaceholderMock(200, ''));

        // Act
        Integer statusCode = JSONPlaceholderExercise.deletePost(1);

        // Assert
        Assert.areEqual(200, statusCode, 'Delete request should return status code 200');
    }
}
