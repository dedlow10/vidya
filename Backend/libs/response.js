export function success(body) {
    const response = {
        statusCode: 200,
        body: JSON.stringify(body),
    };
    return response;
}