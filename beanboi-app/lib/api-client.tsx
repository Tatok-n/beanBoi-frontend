const API_BASE_URL =
  process.env.NEXT_PUBLIC_API_BASE_URL ?? "http://localhost:8090";

type ApiOptions = RequestInit & {
  bodyJson?: unknown;
};

export async function clientApiFetch<T>(
  path: string,
  options: ApiOptions = {}
): Promise<T> {
  const { bodyJson, headers, ...rest } = options;

  const response = await fetch(`${API_BASE_URL}${path}`, {
    ...rest,
    credentials: "include",
    headers: {
      "Content-Type": "application/json",
      ...(headers ?? {}),
    },
    body: bodyJson !== undefined ? JSON.stringify(bodyJson) : rest.body,
  });

  if (!response.ok) {
    const text = await response.text();
    throw new Error(text || `Request failed with status ${response.status}`);
  }


  if (response.status === 204) {
    return undefined as T;
  }

  const text = await response.text();

  if (!text || text.trim() === "") {
     return undefined as T;
  } else {
    return JSON.parse(text) as T;
  }
}
