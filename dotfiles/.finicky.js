const googleMeetApp = {
  browser: ({ urlString }) => ({
    name: "Google Chrome",
    profile: "Default", // use whatever profile created the application shortcut
    args: [
      `--app-id=kjgfgldnnfoeklkmfkjfagphfepbbdan`, // my app ID for my Google Meet application shortcut
      `--app-launch-url-for-shortcuts-menu-item=${urlString}`,
      // notice I'm not passing urlString as an array entry, since Chrome Application Shortcuts don't like that
    ],
  }),
}

module.exports = {
    defaultBrowser: "com.google.Chrome",
    rewrite: [
        {
            match: finicky.matchHostnames(["trello.com"]),
            url: ({ url }) => ({
                ...url,
                protocol: "trello"
            })
        },
    ],
    handlers: [
        {
            match: finicky.matchHostnames(["trello.com"]),
            browser: {
                name: "com.atlassian.trello",
                appType: "bundleId"
            }
        },
        {
            match: finicky.matchHostnames(["meet.google.com"]),
            ...googleMeetApp,
        },
    ]
};
