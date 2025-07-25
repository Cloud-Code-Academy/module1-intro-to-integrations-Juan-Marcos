public class JSONPlaceholderExercise {
    private static final String BASE_URL = 'https://jsonplaceholder.typicode.com';

    /**
     * Exercise 1: Implement a GET request to fetch a post by ID
     * Endpoint: /posts/{postId}
     * @param postId - The ID of the post to fetch
     * @return String - The JSON response from the API
     */
    public static PostResponse getPostById(Integer postId) {
        String endpoint = BASE_URL + '/posts/' + postId;
        HttpResponse response = sendRequest(endpoint, 'GET', null);
        return (PostResponse) JSON.deserialize(response.getBody(), PostResponse.class);
    }

    /**
     * Exercise 2: Implement a POST request to create a new post
     * Endpoint: /posts
     * @param title - The title of the post
     * @param body - The body content of the post
     * @param userId - The user ID creating the post
     * @return String - The JSON response from the API
     */
    public static PostResponse createPost(String title, String body, Integer userId) {
        String endpoint = BASE_URL + '/posts';
        String postData = JSON.serialize(new Map<String, Object>{
            'title' => title,
            'body' => body,
            'userId' => userId
        });
        HttpResponse response = sendRequest(endpoint, 'POST', postData);
        return (PostResponse) JSON.deserialize(response.getBody(), PostResponse.class);
    }

    /**
     * Exercise 3: Implement a PUT request to update a post
     * Endpoint: /posts/{postId}
     * @param postId - The ID of the post to update
     * @param title - The new title
     * @param body - The new body content
     * @param userId - The user ID
     * @return String - The JSON response from the API
     */
    public static PostResponse updatePost(Integer postId, String title, String body, Integer userId) {
        String endpoint = BASE_URL + '/posts/' + postId;
        String updatedPostData = JSON.serialize(new Map<String, Object>{
            'postId' => postId,
            'title' => title,
            'body' => body,
            'userId' => userId
        });
        HttpResponse response = sendRequest(endpoint, 'PUT', updatedPostData);
        return (PostResponse) JSON.deserialize(response.getBody(), PostResponse.class);
    }

    /**
     * Exercise 4: Implement a PATCH request to partially update a post
     * Endpoint: /posts/{postId}
     * @param postId - The ID of the post to patch
     * @param title - The new title (can be null)
     * @return String - The JSON response from the API
     */
    public static PostResponse patchPostTitle(Integer postId, String title) {
        String endpoint = BASE_URL + '/posts/' + postId;
        String patchData = JSON.serialize(new Map<String, Object>{'title' => title});
        HttpResponse response = sendRequest(endpoint, 'PATCH', patchData);
        return (PostResponse) JSON.deserialize(response.getBody(), PostResponse.class);
    }

    /**
     * Exercise 5: Implement a DELETE request to remove a post
     * Endpoint: /posts/{postId}
     * @param postId - The ID of the post to delete
     * @return Integer - The HTTP status code from the response
     */
    public static Integer deletePost(Integer postId) {
        String endpoint = BASE_URL + '/posts/' + postId;
        HttpResponse response = sendRequest(endpoint, 'DELETE', null);
        return response.getStatusCode();
    }

    /**
     * Helper method to send HTTP requests
     * @param endpoint - The full endpoint URL
     * @param method - The HTTP method (GET, POST, PUT, PATCH, DELETE)
     * @param body - The request body (can be null)
     * @return HttpResponse - The response from the HTTP call
     */
    /**
     * Helper method to send HTTP requests with error handling
     * @param endpoint - The full endpoint URL
     * @param method - The HTTP method (GET, POST, PUT, PATCH, DELETE)
     * @param body - The request body (can be null)
     * @return HttpResponse - The response from the HTTP call
     * @throws CalloutException if the HTTP call fails
     */
    private static HttpResponse sendRequest(String endpoint, String method, String body) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod(method);
        request.setHeader('Content-Type', 'application/json');
        if (body != null) {
            request.setBody(body);
        }
        Http http = new Http();
        HttpResponse response = http.send(request);
        Integer statusCode = response.getStatusCode();
        if (statusCode < 200 || statusCode >= 300) {
            System.debug('HTTP error: status code ' + statusCode + ' for endpoint: ' + endpoint + '. Body: ' + response.getBody());
            throw new CalloutException('HTTP error: status code ' + statusCode);
        }
        return response;
    }

    public class PostResponse {
        public Integer id;
        public String title;
        public String body;
        public Integer userId;
    }
}
